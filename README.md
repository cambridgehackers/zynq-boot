zynq-boot
=========

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

    # step 4: configure the kernel
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

