zynq-boot
=========

Scripts to create a boot.bin file for linux on Xilinx Zync

The boot.bin file contains:
1) First Stage Boot Loader (fsbl).  This file does limited initialization
    of the ARM processor and also initializes the DRAM controller, giving access
    to RAM.  Note that the attached DRAM is different between zedboard/zc702.
    This is a binary file imported from a
    Xilinx tool release.  If you wish to build a new one for some reason,
    directions are at:
        http://www.wiki.xilinx.com/Build+FSBL
    (you need to use the Xilinx IDE to create a project and then use their
    Codesourcery gcc toolchain to compile).
2) zImage.  This is the linux kernel, compiled from:
    github.com:cambridgehackers/device_xilinx_kernel.git
3) ramdisk.  This is created from the files in the 'data/' directory
    of this git repo.
4) devicetree.dtb.  This is the devicetree specification of peripherial
    addresses, to avoid wiring them down in the source code of the device
    driver.  (Needed since most peripherials are not discoverable through
    runtime probing).  Note that the peripherials are different between
    the zedboard and the zc702 board.

The boot.bin is board-specific, because the first stage boot loader
(fsbl) and the devicetree are both board-specific.

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

Building on Mac
===============
1) clone device_xilinx_kernel.git
2) clone cambridgehackers/mac_linux_headers.git
3) use mac_linux_headers/compile.sh for running 'make' on device_xilinx_kernel
    (this will create a usable dts executable for creating boot.bin from this repo)

Building just the devicetree compiler needed for zynq-boot (when you don't want to build the entire kernel):
===================================================
    git clone https://github.com/cambridgehackers/device_xilinx_kernel.git
    cd device_xilinx_kernel/
    git checkout remotes/origin/xilinx-v14.6.02-qrc1 -b xilinx-v14.6.02-qrc1
    make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- xilinx_zynq_portal_defconfig
    make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- M=scripts/dtc

Even though the build complains about a missing arm-none-linux-gnueabi-gcc,
it still builds the executable scripts/dtc/dtc correctly.
