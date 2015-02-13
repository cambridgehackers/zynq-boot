#!/usr/bin/python
## Copyright (c) 2014 Quanta Research Cambridge, Inc.

## Permission is hereby granted, free of charge, to any person
## obtaining a copy of this software and associated documentation
## files (the "Software"), to deal in the Software without
## restriction, including without limitation the rights to use, copy,
## modify, merge, publish, distribute, sublicense, and/or sell copies
## of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:

## The above copyright notice and this permission notice shall be
## included in all copies or substantial portions of the Software.

## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
## EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
## MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
## NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
## BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
## ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
## CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.

import os, sys
import argparse

target_string = 'THE NEXT FIELD IS THE LOCAL MAC ADDRESS FOR UPDATE'
dtb_header = [0, 0, 0, 0, 0, 3, 0, 0, 0, 6, 0, 0, 2, 0x6c]
if len(sys.argv) != 3:
    print 'update_bootbin_mac: Usage: update_bootbin_mac.py <filename> <new_hex_value>'
    sys.exit(1)
inbuf = open(sys.argv[1], 'r+b').read()
ind = inbuf.index(target_string)
if ind < 0:
    print 'update_bootbin_mac: string not found', target_string
    sys.exit(1)
#print 'JJ', ind, len(inbuf)
ind = ind + len(target_string)
if ind + len(dtb_header) + 7 > len(inbuf):
    print 'update_bootbin_mac: file too short'
    sys.exit(1)
for cbyte in dtb_header:
    if ord(inbuf[ind]) != cbyte:
        print 'update_bootbin_mac: byte not found', ind, cbyte
        sys.exit(1)
    ind = ind + 1
print 'current', [p.encode('hex') for p in inbuf[ind: ind + 6]]
inbuf = inbuf[:ind+4] + chr(int(sys.argv[2], 0)) + inbuf[ind+5:]
open(sys.argv[1], 'w+b').write(inbuf)
sys.exit(0)
