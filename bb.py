#!/usr/bin/env python

# Copyright (c) 2013 Quanta Research Cambridge, Inc.

# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use, copy,
# modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
import sys
from subprocess import call

sys.path.append('../connectal/scripts')

from adb import adb_commands
from adb import common

if os.environ.has_key('RUNPARAM'):
    ipaddr = os.environ['RUNPARAM']
else:
    ipaddr = None
if ipaddr.find(':') == -1:
    ipaddr = ipaddr + ':5555'

def rmfile(fname):
    try:
        os.remove(fname)
    except OSError as e:
        pass

if __name__ == '__main__':
    # delete files to force rebuilds
    rmfile('zImage')
    rmfile('boot.bin')

    # rebuild zImage and boot.bin
    call(['make', 'zImage'])
    call(['make', 'bootbin.zedboard'])

    # connect to the board
    device_serial = ipaddr
    print 'connecting to %s' % device_serial
    connected = False
    while not connected:
        try:
            connection = adb_commands.AdbCommands.ConnectDevice(serial=device_serial)
            connected = True
        except socket.error:
            pass

    print 'Reconnecting'
    connected = False
    while not connected:
        try:
            connection = adb_commands.AdbCommands.ConnectDevice(serial=device_serial)
            connected = True
        except socket.error:
            pass

    print 'Sending files to the zedboard'
    connection.Push('boot.bin', '/mnt/sdcard/boot.bin')
    connection.Reboot()


