#

all: zcomposite.elf
	if [ -f boot.bin ]; then mv -v boot.bin boot.bin.bak; fi
	bootgen -image boot.bif -o i boot.bin
	rm -f zcomposite.elf

zcomposite.elf: ramdisk
	objcopy -I binary -O elf32-little imagefiles/zImage z.tmp
	objcopy -I binary -O elf32-little ramdisk.image.gz r.tmp
	objcopy -I binary -O elf32-little imagefiles/devicetree.dtb d.tmp
	arm-none-linux-gnueabi-gcc -c clearreg.S
	arm-none-linux-gnueabi-ld -Ttext-segment 0 -e 0 -o c.tmp clearreg.o
	ld -b elf32-little --accept-unknown-input-arch  -z max-page-size=0x8000 -o zcomposite.elf -T zynq_linux_boot.lds 
	rm -f z.tmp r.tmp d.tmp c.tmp clearreg.o ramdisk.image.gz

ramdisk:
	cd data; (find . -name unused -o -print | cpio -H newc -o | gzip -9 -n | dd of=../ramdisk.image.gz bs=256k iflag=fullblock conv=sync)
