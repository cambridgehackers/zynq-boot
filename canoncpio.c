
/* Copyright (c) 2014 Quanta Research Cambridge, Inc
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

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <stdint.h>
#include <sys/types.h>
#include <unistd.h>

typedef struct {
    uint8_t c_magic[6];
    uint8_t c_ino[8];
    uint8_t c_mode[8];
    uint8_t c_uid[8];
    uint8_t c_gid[8];
    uint8_t c_nlink[8];
    uint8_t c_mtime[8];
    uint8_t c_filesize[8];
    uint8_t c_maj[8];
    uint8_t c_min[8];
    uint8_t c_rmaj[8];
    uint8_t c_rmin[8];
    uint8_t c_namesize[8];
    uint8_t c_chksum[8];
} Cpio_header;

#define MAX_FILENAME 1000
#define MAX_FILECOUNT 500
#define MAX_SEGMENT 1000
#define ALIGN32(A) (((A) + 3) & ~3L)

static uint32_t ino_map[MAX_FILECOUNT];
static int ino_map_index = 0;
static uint8_t canon_time[8] = "5361C6C0"; // 2014 May 1

static uint32_t get_int32(uint8_t *data)
{
    uint8_t temp[9];
    memcpy(temp, data, 8);
    temp[8] = 0;
    return strtol(temp, NULL, 16);
}

int main(int argc, const char **argv)
{
    Cpio_header header;
    uint32_t ino, nlen, newi;
    uint8_t data[MAX_SEGMENT], temp[MAX_FILENAME];
    int fd = 0; //open("xx.old", O_RDONLY);
    int verbose = 0;
    if (argc > 1 && strcmp(argv[1], "--verbose") == 0)
	verbose = 1;

    do {
        read(fd, &header, sizeof(header));
        memcpy(temp, header.c_magic, sizeof(header.c_magic));
        temp[sizeof(header.c_magic)] = 0;
        if (strcmp(temp, "070701")) {
            fprintf(stderr, "Invalid magic number in cpio archive %s\n", temp);
            exit(-1);
        }
        ino = get_int32(header.c_ino);
        nlen = get_int32(header.c_namesize);
        /* read filename */
        read(fd, temp, nlen);
        temp[nlen] = 0;
        /* remap inode numbers into 1..MAX range */
        for (newi = 0; newi < MAX_FILECOUNT; newi++) {
            if (newi == ino_map_index)
                ino_map[ino_map_index++] = ino;
            if (ino_map[newi] == ino)
                break;
        }
        int len = ALIGN32(sizeof(header) + nlen)
              + ALIGN32(get_int32(header.c_filesize)) - sizeof(header) - nlen;
	if (verbose)
	    fprintf(stderr, "name %s\t\t\t %x new %x mtime %x\n", temp, ino, newi+1, get_int32(header.c_mtime));
        sprintf(data, "%08X", newi+1);
        if (ino)
            memcpy(header.c_ino, data, sizeof(header.c_ino));
        /* Set file modification time to a constant */
        memcpy(header.c_mtime, canon_time, sizeof(header.c_mtime));
        write(1, &header, sizeof(header));
        write(1, temp, nlen);
        /* read remainder of file */
        if (!strcmp(temp, "TRAILER!!!"))
            len = 9999999; /* HACK */
        /* read alignment filler and data bytes */
        while (len > 0) {
            int plen = len;
            if (plen > sizeof(data))
                plen = sizeof(data);
            int rc = read(fd, data, plen);
            if (rc == 0)
                break;
            write(1, data, rc);
            len -= rc;
        }
    } while (strcmp(temp, "TRAILER!!!"));
    return 0;
}
