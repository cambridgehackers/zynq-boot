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
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <libgen.h>
#include <unistd.h>
//#ifdef __APPLE__
//#include <machine/endian.h>
//#else
//#include <endian.h>
//#endif
#include "elfdef.h"
#include "bootdef.h"

#define BUFFER_SIZE 1024
#define MAX_FILENAME 1000
#define INPUT_FILE_MAX    10

static int         fdoutfile;
static uint8_t    *input_data[INPUT_FILE_MAX];
static ImageHeader imagehead[INPUT_FILE_MAX];
static int         image_offset[INPUT_FILE_MAX];
static uint8_t     buffer[BUFFER_SIZE];
static BootPartitionHeader partinit[10];
static struct {
    uint8_t  *datap;
    uint32_t len;
} partition_data[10];

/* From TRM, Chapter 6: Boot and Configuration */
static ImageHeaderTable imagetab = {0x1010000};
static uint32_t boot_rom_header[32] = {ROM_HEADER};
static uint8_t elfmagic[] = {ELF_MAGIC};
static uint8_t reserved_for_interrupts[] = {
#include "reserved_for_interrupts.h"
};
static uint8_t bitfile_header[] = {
    0, 9, 0xf, 0xf0, 0xf, 0xf0, 0xf, 0xf0, 0xf, 0xf0, 0, 0, 1, 'a'};

static void fill_file(uint8_t fillbyte, int filllen)
{
    while(filllen-- > 0)
        write(fdoutfile, &fillbyte, sizeof(fillbyte));
}
static void align_file(uint8_t fillbyte, int alignsize)
{
    int filllen = alignsize - (lseek(fdoutfile, 0, SEEK_CUR) & (alignsize - 1));
    if (filllen != alignsize)
        fill_file(fillbyte, filllen);
}

static void addPartition(int ptype, uint8_t *data, uint32_t datalen, uint32_t addr, uint32_t enaddr, uint32_t startsect)
{
    partition_data[imagetab.ImageCount].datap = data;
    partition_data[imagetab.ImageCount].len = datalen;
    partinit[imagetab.ImageCount].ImageWordLen = datalen/4;
    partinit[imagetab.ImageCount].DataWordLen = datalen/4;
    partinit[imagetab.ImageCount].PartitionWordLen = datalen/4;
    partinit[imagetab.ImageCount].LoadAddr = addr;
    partinit[imagetab.ImageCount].ExecAddr = enaddr;
    partinit[imagetab.ImageCount].PartitionAttr = ptype;
    partinit[imagetab.ImageCount].SectionCount = 0;
    partinit[imagetab.ImageCount].Pads[1] = startsect * sizeof(partinit[0])/4;
    partinit[startsect].SectionCount++;
    imagetab.ImageCount++;
}

int main(int argc, char *argv[])
{
    int i, index, j, entry;

    if ((fdoutfile = creat ("boot.bin", 0666)) < 0) {
        printf ("xbootgen <fsbl> <composite>\n");
        exit(-1);
    }
    write(fdoutfile, reserved_for_interrupts, sizeof(reserved_for_interrupts));
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
    align_file(0xff, 0x40);
    int imagetab_offset = lseek(fdoutfile, 0, SEEK_CUR);
    write(fdoutfile, &imagetab, sizeof(imagetab));
    align_file(0xff, 0x40);
    imagetab.ImageOffset = lseek(fdoutfile, 0, SEEK_CUR)/4;

    /* Gather info about each file; build image header table */
    for (index = 0; index < argc - 1; index++) {
        const char *filename = argv[index+1];
        union {
            char c[200];
            uint32_t i[50];
        } nametemp;
        struct stat st;
        int fdinput;
        int startsect = imagetab.ImageCount;
        if ((fdinput = open (filename, O_RDONLY)) < 0) {
            printf ("xbootgen <fsbl> <composite>\n");
            exit(-1);
        }
        stat(filename, &st);
        input_data[index] = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fdinput, 0);
        ELF_HEADER *elfh = (ELF_HEADER *)input_data[index];
        ELF_PROGRAM *progh = (ELF_PROGRAM *)&input_data[index][elfh->h32.e_phoff];
        uint32_t enaddr = elfh->h32.e_entry;
        imagehead[index].next = 0;
        imagehead[index].partition = index * sizeof(partinit[0])/4;
        imagehead[index].count = 0;
        imagehead[index].name_length = 1; /* value of actual partition count */
        if (memcmp(input_data[index], elfmagic, sizeof(elfmagic)) || elfh->h32.e_ident[6] != 1
         || elfh->h32.e_type != ET_EXEC || elfh->h32.e_ident[4] != 1) {
            int i;
            if (!memcmp(bitfile_header, input_data[index], sizeof(bitfile_header))) {
                /* skip bitfile header to get binfile contents */
                uint8_t *inputtemp = input_data[index];
                input_data[index] += sizeof(bitfile_header) - 1;
                while(*input_data[index]++ < 'e') {
                    int len = *input_data[index]++;
                    len = (len << 8) | *input_data[index]++;
                    input_data[index] += len;
                }
                if (*--input_data[index] == 'e')
                    input_data[index] += 1 + sizeof(uint32_t); /* skip over 'e' and length */
                st.st_size -= input_data[index] - inputtemp;
            }
            uint8_t *p = malloc(st.st_size+4);
            uint8_t append_data[] = {0x20, 0, 0, 0};
            memcpy(p, input_data[index], st.st_size);
            memcpy(&p[st.st_size], append_data, sizeof(append_data));
            st.st_size += sizeof(append_data);
            for (i = 0; i < st.st_size; ) {
                uint8_t tmp = p[i];
                p[i] = p[i+3];
                p[i+3] = tmp;
                tmp = p[i+1];
                p[i+1] = p[i+2];
                p[i+2] = tmp;
                i += sizeof(uint32_t);
            }
            addPartition(ATTRIBUTE_PL_IMAGE_MASK, p, st.st_size, 0, 0, startsect);
        }
        else {
            for (entry = 0; entry < elfh->h32.e_phnum; ++entry) {
                uint32_t datalen = progh->p32[entry].p_filesz;
                if (datalen) {
                    /* As we find partitions, add them to the partition header table */
                    addPartition(ATTRIBUTE_PS_IMAGE_MASK, &input_data[index][progh->p32[entry].p_offset],
                        datalen, progh->p32[entry].p_paddr, enaddr, startsect);
                    enaddr = 0;
                }
            }
        }
        /* Build image table entry for each input file */
        image_offset[index] = lseek(fdoutfile, 0, SEEK_CUR);
        write(fdoutfile, &imagehead[index], sizeof(imagehead[0]));
        memset(&nametemp, 0, sizeof(nametemp));
        char basetemp[MAX_FILENAME];
        strcpy(basetemp, filename);
        strcpy(nametemp.c, basename(basetemp));
        int len = ((strlen(nametemp.c) + 16)/16) * 4;
        for (j = 0; j < len; j++) {
            nametemp.i[j] = ntohl(nametemp.i[j]);
            write(fdoutfile, &nametemp.i[j], sizeof(nametemp.i[0]));
        }
        align_file(0xff, 0x40);
    }
    align_file(0xff, 0x400);
    fill_file(0xff, 0x80);
    int partinit_offset = lseek(fdoutfile, 0, SEEK_CUR);
    write(fdoutfile, &partinit, sizeof(partinit[0]) * (imagetab.ImageCount+1));
    align_file(0xff, 0x400);
    fill_file(0xff, 0x700);

    /* Now copy data from each elf file into target file */
    for (index = 0; index < imagetab.ImageCount; index++) {
        align_file(0xff, 0x40);
        partinit[index].PartitionStart = lseek(fdoutfile, 0, SEEK_CUR)/4;
        write(fdoutfile, partition_data[index].datap, partition_data[index].len);
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
    for (index = 0; index < argc - 1; index++) {
        if (index < argc - 1 - 1)
            imagehead[index].next = image_offset[index+1]/4;
        imagehead[index].partition += partinit_offset/4;
        lseek(fdoutfile, image_offset[index], SEEK_SET);
        write(fdoutfile, &imagehead[index], sizeof(imagehead[0]));
    }
    lseek(fdoutfile, imagetab_offset, SEEK_SET);
    imagetab.Version = BOOTGEN_VERSION;
    write(fdoutfile, &imagetab, sizeof(imagetab));
    lseek(fdoutfile, rom_header_offset, SEEK_SET);
    write(fdoutfile, boot_rom_header, sizeof(boot_rom_header));
    lseek(fdoutfile, partinit_offset, SEEK_SET);
    write(fdoutfile, &partinit, sizeof(partinit[0]) * (imagetab.ImageCount+1));
    close(fdoutfile);
    return 0;
}
