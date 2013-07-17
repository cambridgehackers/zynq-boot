#

all: zcomposite.elf imagefiles/zynq_$(BOARD)_fsbl.elf xbootgen
	if [ -f boot.bin ]; then mv -v boot.bin boot.bin.bak; fi
	cp -f imagefiles/zynq_$(BOARD)_fsbl.elf zynq_fsbl.elf
	#bootgen -image boot.bif -o i boot.bin
	./xbootgen zynq_fsbl.elf zcomposite.elf

#DTC=/scratch/jamey/xlaatu/device/xilinx/kernel/scripts/dtc/dtc
DTC=../device_xilinx_kernel/scripts/dtc/dtc

imagefiles/zynq-$(BOARD)-bridge.dtb: imagefiles/zynq-$(BOARD)-bridge.dts
	cp imagefiles/zynq-$(BOARD)-bridge.dts dtswork.tmp
	macbyte=`echo $USER | md5sum | cut -c 1-2`; sed -i s/73/$$macbyte/ dtswork.tmp
	$(DTC) -I dts -O dtb -o imagefiles/zynq-$(BOARD)-bridge.dtb dtswork.tmp
	rm -f dtswork.tmp

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

xbootgen: xbootgen.c Makefile
	arm-none-linux-gnueabi-gcc -c reserved_for_interrupts.S
	arm-none-linux-gnueabi-ld -Ttext-segment 0 -e 0 -o c.tmp reserved_for_interrupts.o
	objcopy -O binary -I elf32-little c.tmp reserved_for_interrupts.tmp
	rm -f c.tmp
	gcc -g -o xbootgen xbootgen.c
