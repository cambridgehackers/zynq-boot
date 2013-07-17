/* Copyright 2013, John Ankcorn
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>
#include <arpa/inet.h>
#include <endian.h>

#define BUFFER_SIZE 1024

/************ elf header structures ****************/
typedef struct {
    unsigned char e_ident[16];
    uint16_t  e_type;
#define ET_EXEC 2
    uint16_t  e_machine;
    uint32_t  e_version;
    uint32_t  e_entry;
    uint32_t  e_phoff;
    uint32_t  e_shoff;
    uint32_t  e_flags;
    uint16_t  e_ehsize;
    uint16_t  e_phentsize;
    uint16_t  e_phnum;
    uint16_t  e_shentsize;
    uint16_t  e_shnum;
    uint16_t  e_shstrndx;
} elf_header;

enum{PT_NULL, PT_LOAD, PT_DYNAMIC, PT_INTERP, PT_NOTE, PT_SHLIB, PT_PHDR};
typedef struct {
    uint32_t  p_type;
    uint32_t  p_offset;
    uint32_t  p_vaddr;
    uint32_t  p_paddr;
    uint32_t  p_filesz;
    uint32_t  p_memsz;
    uint32_t  p_flags;
    uint32_t  p_align;
} program_header;

/************ boot.bin header structures ****************/
#define ATTRIBUTE_PS_IMAGE_MASK  0x10    /**< Code partition */
#define ATTRIBUTE_PL_IMAGE_MASK  0x20    /**< Bit stream partition */
typedef struct {
    uint32_t Version;
    uint32_t ImageCount;
    uint32_t PartitionOffset;
    uint32_t ImageOffset;
} ImageHeaderTable;
typedef struct {
    uint32_t ImageWordLen;
    uint32_t DataWordLen;
    uint32_t PartitionWordLen;
    uint32_t LoadAddr;
    uint32_t ExecAddr;
    uint32_t PartitionStart;
    uint32_t PartitionAttr;
    uint32_t SectionCount;
    uint32_t Pads[7];
    uint32_t CheckSum;
} BootPartitionHeader;
typedef struct {
    uint32_t next;
    uint32_t partition;
    uint32_t count;
    uint32_t name_length;
} ImageHeader;

static int fdinput[2], fdoutfile;
static elf_header       elfh[2];
static ImageHeader imagehead[2];
static int image_offset[2];
static unsigned char    buffer[BUFFER_SIZE];
static BootPartitionHeader partinit[10];
static struct {
    uint32_t offset;
    uint32_t len;
    int      fd;
} partition_data[10];
static BootPartitionHeader part_data[20];

/* From TRM, Chapter 6: Boot and Configuration */
static ImageHeaderTable imagetab = {0x1010000};
static uint32_t boot_rom_header[32] = {
	0xaa995566, 0x584c4e58, 0, 0x1010000, };

static void align_file(void)
{
    static unsigned char fillbyte = 0xff;
    int filllen = 0x40 - (lseek(fdoutfile, 0, SEEK_CUR) & 0x3f);
    if (filllen != 0x40) {
        while(filllen-- > 0)
            write(fdoutfile, &fillbyte, sizeof(fillbyte));
    }
}

int main(int argc, char *argv[])
{
    int i, index, j, entry, input_file_count = 2;

    if (argc != input_file_count + 1 || (fdoutfile = creat ("boot.tmp", 0666)) < 0) {
        printf ("xbootgen <fsbl> <composite>\n");
        exit(-1);
    }
    int tmpfd = open ("d.tmp", O_RDONLY);
    int len = read(tmpfd, buffer, sizeof(buffer));
    close(tmpfd);
    write(fdoutfile, buffer, len);
    int rom_header_offset = lseek(fdoutfile, 0, SEEK_CUR);
    write(fdoutfile, boot_rom_header, sizeof(boot_rom_header));
    /* fill register initialiation area */
    for(i = 0; i < 256; i++) {
        struct {
            uint32_t address;
            uint32_t value;
        } reginit = {0xffffffff, 0};
        write(fdoutfile, &reginit, sizeof(reginit));
    }
    align_file();
    /* Now build image header table */
    for (index = 0; index < input_file_count; index++) {
        int startsect = imagetab.ImageCount;
        if ((fdinput[index] = open (argv[index+1], O_RDONLY)) < 0) {
            printf ("xbootgen <fsbl> <composite>\n");
            exit(-1);
        }
        if (read(fdinput[index], &(elfh[index]), sizeof(elfh[index])) != sizeof(elfh[0])
         || elfh[index].e_ident[0] != 0x7f || elfh[index].e_ident[1] != 'E' || elfh[index].e_ident[2] != 'L'
         || elfh[index].e_ident[3] != 'F' || elfh[index].e_ident[6] != 1
         || elfh[index].e_type != ET_EXEC || elfh[index].e_ident[4] != 1) {
            printf("Error: input file not valid\n");
        }
        int len = elfh[index].e_phentsize * elfh[index].e_phnum;
        if (len == 0)
            continue;
        program_header *progh = malloc(len);
        if (lseek(fdinput[index], elfh[index].e_phoff, SEEK_SET) == -1
         || read(fdinput[index], progh, len) != len) {
            printf("[%s:%d] error in read\n", __FUNCTION__, __LINE__);
        }
        uint32_t enaddr = elfh[index].e_entry;
        for (entry = 0; entry < elfh[index].e_phnum; ++entry) {
            uint32_t datalen = progh[entry].p_filesz;
            if (datalen) {
                /* As we find partitions, add them to the partition header table */
                partition_data[imagetab.ImageCount].offset = progh[entry].p_offset;
                partition_data[imagetab.ImageCount].len = datalen;
                partition_data[imagetab.ImageCount].fd = fdinput[index];
                partinit[imagetab.ImageCount].ImageWordLen = datalen/4;
                partinit[imagetab.ImageCount].DataWordLen = datalen/4;
                partinit[imagetab.ImageCount].PartitionWordLen = datalen/4;
                partinit[imagetab.ImageCount].LoadAddr = progh[entry].p_paddr;
                partinit[imagetab.ImageCount].ExecAddr = enaddr;
                partinit[imagetab.ImageCount].PartitionAttr = ATTRIBUTE_PS_IMAGE_MASK;
                partinit[imagetab.ImageCount].SectionCount = 0;
                partinit[imagetab.ImageCount].Pads[1] = startsect * sizeof(partinit[0])/4;
                partinit[startsect].SectionCount++;
                imagetab.ImageCount++;
                enaddr = 0;
            }
        }
    }
    int imagetab_offset = lseek(fdoutfile, 0, SEEK_CUR);
    write(fdoutfile, &imagetab, sizeof(imagetab));
    align_file();

    /* Now build image table entry for each input file */
    imagetab.ImageOffset = lseek(fdoutfile, 0, SEEK_CUR)/4;
    for (index = 0; index < input_file_count; index++) {
        union {
            char c[200];
            uint32_t i[50];
        } nametemp;
        imagehead[index].next = 0;
        imagehead[index].partition = index * sizeof(partinit[0])/4;
        imagehead[index].count = 0;
        imagehead[index].name_length = index + 1; /* value of actual partition count */
        image_offset[index] = lseek(fdoutfile, 0, SEEK_CUR);
        write(fdoutfile, &imagehead[index], sizeof(imagehead[0]));

        memset(&nametemp, 0, sizeof(nametemp));
        strcpy(nametemp.c, argv[1+index]);
        int len = (strlen(nametemp.c) + 7)/4;
        for (j = 0; j < len; j++) {
            nametemp.i[j] = ntohl(nametemp.i[j]);
            write(fdoutfile, &nametemp.i[j], sizeof(nametemp.i[0]));
        }
        align_file();
    }
    int partinit_offset = lseek(fdoutfile, 0, SEEK_CUR);
    write(fdoutfile, &partinit, sizeof(partinit[0]) * (imagetab.ImageCount+1));

    /* Now copy data from each elf file into target file */
    for (index = 0; index < imagetab.ImageCount; index++) {
        align_file();
        lseek(partition_data[index].fd, partition_data[index].offset, SEEK_SET);
        uint32_t readlen = partition_data[index].len;
        partinit[index].PartitionStart = lseek(fdoutfile, 0, SEEK_CUR)/4;
        while (readlen > 0) {
            int readitem = readlen;
            if (readitem > sizeof(buffer))
                readitem = sizeof(buffer);
            int len = read(partition_data[index].fd, buffer, readitem);
            if (len != readitem) {
                printf("tried to read file %d length %d actual %d\n", index, readitem, len);
                exit(1);
            }
            write(fdoutfile, buffer, len);
            readlen -= len;
        }
    }

    /* fixup header tables */
    imagetab.PartitionOffset = partinit_offset/4;
    boot_rom_header[4] = partinit[0].PartitionStart * 4;
    boot_rom_header[5] = partition_data[0].len;
    boot_rom_header[8] = partition_data[0].len;
    boot_rom_header[9] = 1;
    boot_rom_header[30] = imagetab_offset;
    boot_rom_header[31] = partinit_offset;
    for (index = 0; index < 10; index++)
         boot_rom_header[10] += boot_rom_header[index];
    boot_rom_header[10] = ~boot_rom_header[10];
    /* last partition entry is all '0' */
    for (i = 0; i <= imagetab.ImageCount; i++) {
        if (i != imagetab.ImageCount)
            partinit[i].Pads[1] += imagetab.ImageOffset;
        uint32_t checksum = 0, *pdata = (uint32_t *)&partinit[i];
        for (j = 0; j < 15; j++)
             checksum += *pdata++;
        partinit[i].CheckSum = ~checksum;
    }

    /* rewrite header tables */
    for (index = 0; index < input_file_count; index++) {
        if (index < input_file_count - 1)
            imagehead[index].next = image_offset[index+1]/4;
        imagehead[index].partition += partinit_offset/4;
        lseek(fdoutfile, image_offset[index], SEEK_SET);
        write(fdoutfile, &imagehead[index], sizeof(imagehead[0]));
    }
    lseek(fdoutfile, imagetab_offset, SEEK_SET);
    write(fdoutfile, &imagetab, sizeof(imagetab));
    lseek(fdoutfile, rom_header_offset, SEEK_SET);
    write(fdoutfile, boot_rom_header, sizeof(boot_rom_header));
    lseek(fdoutfile, partinit_offset, SEEK_SET);
    write(fdoutfile, &partinit, sizeof(partinit[0]) * (imagetab.ImageCount+1));
    close(fdoutfile);
    return 0;
}
