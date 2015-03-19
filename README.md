zynq-boot
=========

The boot.bin file is board specific and contains the MAC address for
the ethernet, so you need a unique one for each type of board you use
on a network. If you only have one board, you can use prebuilt images
from the versioned branch of zynq-boot-filesystems:

* https://github.com/cambridgehackers/zynq-boot-filesystems/tree/v15.03.2

From that link, download:

* https://github.com/cambridgehackers/zynq-boot-filesystems/blob/v15.03.2/sdcard-zynq.zip

also download a bootbin*.zip for your board:

* zedboard: https://github.com/cambridgehackers/zynq-boot-filesystems/blob/v15.03.2/bootbin-zedboard-00e00c009603.zip
* zc702: https://github.com/cambridgehackers/zynq-boot-filesystems/blob/v15.03.2/bootbin-zc702-00e00c005603.zip
* zc706: https://github.com/cambridgehackers/zynq-boot-filesystems/blob/v15.03.2/bootbin-zc706-00e00c004f03.zip

My SD card is labeled "ZYNQ" and under Ubuntu mounts as
/media/jamey/ZYNQ. On OS X it mounts as /Volumes/ZYNQ. Update the
following with the path to your SD card:

   unzip sdcard-zynq.zip
   cp sdcard-zynq/* /media/jamey/ZYNQ
   unzip bootbin*.zip
   cp bootbin*03/* /media/jamey/ZYNQ

Now eject your SD card, plug it into the Zynq board, and turn it on.

Creating boot.bin
=================

Scripts to create a boot.bin file for linux on Xilinx Zync

The boot.bin file contains 4 components:

1) First Stage Boot Loader (fsbl).

This file does limited initialization of the ARM processor and also
initializes the DRAM controller, giving access to RAM.  Note that the
attached DRAM is different between zedboard/zc702.  This is a binary
file imported from a Xilinx tool release.  If you wish to build a new
one for some reason, directions are at:

  * http://www.wiki.xilinx.com/Build+FSBL

(you need to use the Xilinx IDE to create a project and then use their
Codesourcery gcc toolchain to compile).

2) zImage.

This is the linux kernel, compiled from:

  * github.com:cambridgehackers/linux-xlnx.git

3) ramdisk.

This is created from the files in the 'data/' directory of this git
repo.

4) devicetree.dtb.

This is the devicetree specification of peripherial addresses, to
avoid wiring them down in the source code of the device driver.
(Needed since most peripherials are not discoverable through runtime
probing).  Note that the peripherials are different between the
zedboard and the zc702 board.

The boot.bin is board-specific, because the first stage boot loader
(fsbl) and the devicetree are both board-specific.

Building Zynq-Boot
================

To see all possible make targets, please just type:

    make

To build a everything for a zedboard:

    make all.zedboard

To build just a boot.bin for a zedboard:

    make bootbin.zedboard

To build a everything for a zc702:

    make all.zc702

To build a everything for a zc706:

    make all.zc706

Compiling the linux kernel on Linux:
====================================

If you would like to use a different kernel, you can make it from source.

    # step 1: get the linux kernel source
    git clone git@github.com:cambridgehackers/linux-xlnx.git

    # step 2:
    cd linux-xlnx/

    # step 3: check out the xbsv-2014.04 branch
    git checkout remotes/origin/xbsv-2014.04 -b xbsv-2014.04

    # step 4: configure the kernel. We use CodeSourcery 2009q1. The NDK toolchain does not work for this.
    make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- xilinx_zynq_portal_defconfig  

    # step 5: make the kernel
    make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-   

    # step 6: copy the new kernel into zynq-boot
    cp arch/arm/boot/zImage ../zynq-boot/imagefiles/zImage  

Compiling the xbsv device drivers on linux:

Compiling the linux kernel on Mac:
==================================

1) clone linux-xlnx.git

2) clone cambridgehackers/mac_linux_headers.git

3) use mac_linux_headers/compile.sh for running 'make' on linux-xlnx

(this will create a usable dts executable for creating boot.bin from this repo)

Updating the device tree
========================

The devicetree compiler source code is part of the Linux kernel source
code. Here is how to build the devicetree compiler without building
the entire kernel:

    git clone https://github.com/cambridgehackers/linux-xlnx.git
    cd linux-xlnx/
    git checkout origin/xbsv-2014.04 -b xbsv-2014.04
    make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- xilinx_zynq_portal_defconfig
    make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- M=scripts/dtc

Even though the build complains about a missing arm-none-linux-gnueabi-gcc,
it still builds the executable scripts/dtc/dtc correctly.

Support for Mini-ITX
======================
Support has been added for the Avnet 7Z100 Mini-ITX development kit:

    http://www.zedboard.org/product/mini-itx

Changing Ethernet MAC address
=============================
The ethernet MAC address is derived from your $(USER) name.  
To make boot.bin files for multiple devices that are attached to the network at the same time:

    make bootbin.zedboard USER=uniquetringforboard

Adding new boards
=================

To add a new board:

    1) Add the boardname to Makefile

    2) add zynq-<boardname>-portal.dts zynq_<boardname>_fsbl.elf to imagefiles/

    3) make sure that bootargs in the dts file is updated to reflect the boot ramdisk and /dev/fpgaXXX devices

Sources of xxxx_fsbl.elf files
==============================

Currently:

zynq_zedboard_fsbl.elf:

    * http://www.digilentinc.com/Data/Products/ZEDBOARD/ZedBoard_OOB_Design.zip

    * filename: ZedBoard_OOB_Design/boot_image/zynq_fsbl.elf

zynq_miniitx100_fsbl.elf:

    * http://www.zedboard.org/support/design/2056/17

        * Login/Download "Zynq Mini-ITX 7Z100 Out-of-Box Linux v2013.4"

        * filename: ZMITX_7100_OOB_Linux_VIV2013_4/Xil/sdk_workspace/zmitx_fsbl/Debug/zmitx_fsbl.elf

Future sources (update as needed):

    * http://www.wiki.xilinx.com/Zynq+2014.2+Release
        * zynq_zc706_fsbl.elf: zc70x/zc706/fsbl.elf
        * zynq_zc702_fsbl.elf: zc70x/zc702/fsbl.elf
        * zynq_zedboard_fsbl.elf: zed/fsbl.elf

