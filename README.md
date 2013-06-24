zynq-boot
=========

Scripts to create a boot.bin file for linux on Xilinx Zync

The boot.bin is board-specific, because the first stage boot loader
(fsbl) and the devicetree are both board-specific.

To build a boot.bin for a zedboard:
   make BOARD=zedboard all

To build a boot.bin for a zc702:
   make BOARD=zc702 all

