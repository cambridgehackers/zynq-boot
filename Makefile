#

all: zcomposite.elf imagefiles/zynq_$(BOARD)_fsbl.elf
	if [ -f boot.bin ]; then mv -v boot.bin boot.bin.bak; fi
	cp -f imagefiles/zynq_$(BOARD)_fsbl.elf zynq_fsbl.elf
	bootgen -image boot.bif -o i boot.bin
	rm -f zcomposite.elf

#DTC=/scratch/jamey/xlaatu/device/xilinx/kernel/scripts/dtc/dtc
DTC=../device_xilinx_kernel/scripts/dtc/dtc

imagefiles/zynq-$(BOARD)-bridge.dtb: imagefiles/zynq-$(BOARD)-bridge.dts
	if [ "$$USER" = "jamey" ]; then sed -i "s/00 E0 0C 00 73 03/00 E0 0C 00 73 05/" image
	if [ "$$USER" = "mdk" ]; then sed -i "s/00 E0 0C 00 73 03/00 E0 0C 00 73 07/" image
	$(DTC) -I dts -O dtb -o imagefiles/zynq-$(BOARD)-bridge.dtb imagefiles/zynq-$(BOARD)-bridge.dts

zcomposite.elf: ramdisk imagefiles/zynq-$(BOARD)-bridge.dtb
	objcopy -I binary -O elf32-little imagefiles/zImage z.tmp
	objcopy -I binary -O elf32-little ramdisk.image.gz r.tmp
	objcopy -I binary -O elf32-little imagefiles/zynq-$(BOARD)-bridge.dtb d.tmp
	rm -f imagefiles/zynq-$(BOARD)-bridge.dtb
	arm-none-linux-gnueabi-gcc -c clearreg.S
	arm-none-linux-gnueabi-ld -Ttext-segment 0 -e 0 -o c.tmp clearreg.o
	ld -b elf32-little --accept-unknown-input-arch  -z max-page-size=0x8000 -o zcomposite.elf -T zynq_linux_boot.lds 
	rm -f z.tmp r.tmp d.tmp c.tmp clearreg.o ramdisk.image.gz

ramdisk:
	cd data; (find . -name unused -o -print | cpio -H newc -o | gzip -9 -n | dd of=../ramdisk.image.gz bs=256k iflag=fullblock conv=sync)
