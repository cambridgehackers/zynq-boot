#
#NDKPATH=/scratch/android-ndk-r9d/
NDK_OBJDUMP=$(shell $(NDKPATH)ndk-which objdump)
NDK_GCC=$(shell $(NDKPATH)ndk-which gcc)
PREFIX=$(NDK_OBJDUMP:%-objdump=%-)
DTC=./bin/dtc
KERNELID=3.9.0-00054-g7b6edac
DELETE_TEMP_FILES=1

targetnames = bootbin sdcard all

all:
	@echo "Please type one of the following:"
	@echo "    make bootbin.zedboard"
	@echo "    make sdcard.zedboard"
	@echo "    make all.zedboard"
	@echo "    make bootbin.zc702"
	@echo "    make sdcard.zc702"
	@echo "    make all.zc702"
	@echo "    make bootbin.zc706"
	@echo "    make sdcard.zc706"
	@echo "    make all.zc706"
	@echo "    make bootbin.miniitx100"
	@echo "    make sdcard.miniitx100"
	@echo "    make all.miniitx100"

#################################################################################################
# zedboard
zedboardtargets = $(addsuffix .zedboard, $(targetnames))
zedboardtargets: $(zedboardtargets)
$(zedboardtargets):
	make BOARD=zedboard real.$(basename $@)
#################################################################################################
# zc702
zc702targets = $(addsuffix .zc702, $(targetnames))
zc702targets: $(zc702targets)
$(zc702targets):
	make BOARD=zc702 real.$(basename $@)
#################################################################################################
# zc706
zc706targets = $(addsuffix .zc706, $(targetnames))
zc706targets: $(zc706targets)
$(zc706targets):
	make BOARD=zc706 real.$(basename $@)
#################################################################################################
# miniitx100
miniitx100targets = $(addsuffix .miniitx100, $(targetnames))
miniitx100targets: $(miniitx100targets)
$(miniitx100targets):
	make BOARD=miniitx100 real.$(basename $@)
#################################################################################################

real.all: real.bootbin real.sdcard

clean:
	## '"make realclean" to remove downloaded files
	rm -fr sdcard-* boot.bin *.tmp *.elf *.gz *.hex *.o foo.map xbootgen canoncpio

realclean: clean
	rm -fr filesystems/*

real.bootbin: zcomposite.elf imagefiles/zynq_$(BOARD)_fsbl.elf xbootgen reserved_for_interrupts.tmp
	if [ -f boot.bin ]; then mv -v boot.bin boot.bin.bak; fi
	cp -f imagefiles/zynq_$(BOARD)_fsbl.elf zynq_fsbl.elf
	./xbootgen zynq_fsbl.elf zcomposite.elf
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f zynq_fsbl.elf zcomposite.elf reserved_for_interrupts.tmp
endif

dtb.tmp: imagefiles/zynq-$(BOARD)-portal.dts
	macbyte=`echo $(USER)$(BOARD) | md5sum | cut -c 1-2`; sed s/73/$$macbyte/ <imagefiles/zynq-$(BOARD)-portal.dts >dtswork.tmp
	## first time, just to see if $(DTC) executes
	$(DTC) -I dts -O dtb -o dtb.tmp dtswork.tmp || make bin/dtc
	## second time, to make dtb.tmp
	$(DTC) -I dts -O dtb -o dtb.tmp dtswork.tmp
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f dtswork.tmp
endif

zcomposite.elf: ramdisk dtb.tmp
	echo "******** PRINT GCC CONFIGURE OPTIONS *******"
	$(PREFIX)gcc -v 2>&1
	$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm imagefiles/zImage z.tmp
	$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm ramdisk.image.gz r.tmp
	$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm dtb.tmp d.tmp
	$(PREFIX)gcc -c clearreg.S
	$(PREFIX)ld -z noexecstack -Ttext 0 -e 0 -o c.tmp clearreg.o
	$(PREFIX)objcopy -I elf32-littlearm -O binary c.tmp c1.tmp
	$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm c1.tmp c.tmp
	$(PREFIX)ld -e 0x1008000 -z max-page-size=0x8000 -o zcomposite.elf --script zynq_linux_boot.lds r.tmp d.tmp c.tmp z.tmp
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f z.tmp r.tmp d.tmp c.tmp c1.tmp clearreg.o ramdisk.image.gz dtb.tmp
endif

canoncpio: canoncpio.c
	gcc -o canoncpio canoncpio.c

ramdisk: canoncpio
	chmod 644 data/*.rc data/*.prop
	cd data; (find . -name unused -o -print | sort | cpio -H newc -o >../ramdisk.image.temp1)
	./canoncpio < ramdisk.image.temp1 | gzip -9 -n >ramdisk.image.temp
	cat ramdisk.image.temp /dev/zero | dd of=ramdisk.image.gz count=256 ibs=1024
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f ramdisk.image.temp ramdisk.image.temp1
endif

xbootgen: xbootgen.c Makefile
	gcc -g -o xbootgen xbootgen.c

dumpbootbin: dumpbootbin.c Makefile
	gcc -g -o dumpbootbin dumpbootbin.c

reserved_for_interrupts.tmp: reserved_for_interrupts.S
	$(PREFIX)gcc -c reserved_for_interrupts.S
	$(PREFIX)ld -Ttext 0 -e 0 -o i.tmp reserved_for_interrupts.o
	$(PREFIX)objcopy -O binary -I elf32-little i.tmp reserved_for_interrupts.tmp
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f i.tmp reserved_for_interrupts.o
endif

real.sdcard: sdcard-$(BOARD)/system.img sdcard-$(BOARD)/userdata.img sdcard-$(BOARD)/boot.bin
	cp -v imagefiles/zynqportal.ko imagefiles/portalmem.ko imagefiles/timelimit sdcard-$(BOARD)/
	[ -e sdcard-$(BOARD)/$(KERNELID) ] || mkdir sdcard-$(BOARD)/$(KERNELID)
	echo "Files for $(BOARD) SD Card are in $(PWD)/sdcard-$(BOARD)"

.PHONY: real.sdcard real.bootbin real.all

sdcard-$(BOARD)/boot.bin:
	mkdir -p sdcard-$(BOARD)
	rm -f boot.bin
	make BOARD=$(BOARD) real.bootbin
	mv boot.bin sdcard-$(BOARD)/boot.bin

filesystems/system-130710.img.bz2:
	mkdir -p filesystems
	wget 'https://github.com/cambridgehackers/zynq-boot-filesystems/blob/system-130710/system-130710.img.bz2?raw=true' -O filesystems/system-130710.img.bz2

filesystems/userdata.img.bz2:
	mkdir -p filesystems
	wget 'https://github.com/cambridgehackers/zynq-boot-filesystems/blob/userdata/userdata.img.bz2?raw=true' -O filesystems/userdata.img.bz2

sdcard-$(BOARD)/system.img: filesystems/system-130710.img.bz2
	mkdir -p sdcard-$(BOARD)
	bzcat filesystems/system-130710.img.bz2 > sdcard-$(BOARD)/system.img
	(cd sdcard-$(BOARD); md5sum -c ../imagefiles/filesystems.md5sum)

ifeq ($(shell uname), Darwin)
sdcard-$(BOARD)/userdata.img: filesystems/userdata.img.bz2
	mkdir -p sdcard-$(BOARD)
	bzcat filesystems/userdata.img.bz2 > sdcard-$(BOARD)/userdata.img
else
sdcard-$(BOARD)/userdata.img:
	mkdir -p sdcard-$(BOARD)
	# make a 100MB empty filesystem
	dd if=/dev/zero bs=1k count=102400 of=sdcard-$(BOARD)/userdata.img
	mkfs -F -t ext4 sdcard-$(BOARD)/userdata.img
endif

.PHONY: bin/dtc

bin/dtc:
	if [ -d linux-xlnx ]; then true; else git clone git://github.com/cambridgehackers/linux-xlnx.git; fi
	(cd linux-xlnx; \
	git checkout remotes/origin/xbsv-2014.04 -b xbsv-2014.04; \
	make ARCH=arm CROSS_COMPILE=$(shell echo $(NDK_GCC) | sed s/gcc//) xilinx_zynq_portal_defconfig; \
	make ARCH=arm CROSS_COMPILE=$(shell echo $(NDK_GCC) | sed s/gcc//) -j8 zImage; \
	make ARCH=arm CROSS_COMPILE=$(shell echo $(NDK_GCC) | sed s/gcc//) M=scripts/dtc; \
	cp -fv scripts/dtc/dtc ../bin/dtc)
