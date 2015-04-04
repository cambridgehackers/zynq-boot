#
OS := $(shell uname)

LINUX_KERNEL_BRANCH=connectal-2014.04
#LINUX_KERNEL_BRANCH=connectal-xilinx-v2014.4-trd

ifeq ($(OS), Darwin)
MD5PROG = md5
DTC=./bin/dtc
MACHEADERS = HOSTCFLAGS="-I../mac_linux_headers"
else
MD5PROG = md5sum
DTC=./bin/dtc
endif
MKFS=/sbin/mkfs

#BOOTBIN_NDK_OBJDUMP?=arm-none-linux-gnueabi-objdump
BOOTBIN_NDK_OBJDUMP?=$(shell ndk-which objdump)
PREFIX?=$(BOOTBIN_NDK_OBJDUMP:%-objdump=%-)

KERNEL_CROSS?=arm-linux-gnueabi-

KERNELID=3.9.0-00055-g6f85fcc
DELETE_TEMP_FILES?=1

targetnames = bootbin sdcard all

all:
	@echo "Please type one of the following:"
	@echo "    make sdcard-zynq.zip"
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
	@echo "    make bootbin.zybo"
	@echo "    make sdcard.zybo"
	@echo "    make all.zybo"
	@echo "    make zImage"
	@echo "    make zynqdrivers"

#################################################################################################
# zedboard
zedboardtargets = $(addsuffix .zedboard, $(targetnames))
zedboardtargets: $(zedboardtargets)
$(zedboardtargets):
	make BOARD=zedboard real.$(basename $@)

RUNPARAMTEMP=$(subst :, ,$(RUNPARAM):5555)
RUNIP=$(wordlist 1,1,$(RUNPARAMTEMP))
RUNPORT=$(wordlist 2,2,$(RUNPARAMTEMP))

zedboard-adb:
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) shell pwd || true
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) root || true
	sleep 1
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) shell rm -rf /mnt/sdcard/$(KERNELID)
	adb -s $(RUNIP):$(RUNPORT) shell mkdir /mnt/sdcard/$(KERNELID)
	adb -s $(RUNIP):$(RUNPORT) push sdcard-zedboard/boot.bin   /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) push sdcard-zedboard/portalmem.ko    /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) push sdcard-zedboard/system.img    /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) push sdcard-zedboard/timelimit    /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) push sdcard-zedboard/webserver    /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) push sdcard-zedboard/userdata.img    /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) push sdcard-zedboard/zynqportal.ko  /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) shell sync
	adb -s $(RUNIP):$(RUNPORT) shell sync
	adb -s $(RUNIP):$(RUNPORT) reboot

update-adb:
	adb connect $(RUNPARAM)
	adb -s $(RUNIP):$(RUNPORT) push boot.bin   /mnt/sdcard
	adb -s $(RUNIP):$(RUNPORT) reboot

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
# zybo
zybo-BITFILE := bitfile/zybo/zybobsd.bit
zybotargets = $(addsuffix .zybo, $(targetnames))
zybotargets: $(zybotargets)
$(zybotargets):
	make BOARD=zybo real.$(basename $@)
#################################################################################################

ifdef DAFFODIL
MACBYTE=98
else
MACBYTE?=0x$(shell echo $(USER)$(BOARD) | $(MD5PROG) | cut -c 1-2)
endif

real.all: real.bootbin real.sdcard

clean:
	## '"make realclean" to remove downloaded files
	rm -fr sdcard-* boot.bin *.tmp *.elf *.gz *.hex *.o foo.map xbootgen canoncpio

realclean: clean
	rm -fr filesystems/*

real.bootbin: zcomposite.elf imagefiles/zynq_$(BOARD)_fsbl.elf xbootgen
	if [ -f boot.bin ]; then mv -v boot.bin boot.bin.bak; fi
	./xbootgen imagefiles/zynq_$(BOARD)_fsbl.elf $($(BOARD)-BITFILE) zcomposite.elf
	./update_bootbin_mac.py boot.bin $(MACBYTE)
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f zcomposite.elf
endif

# daffodil's zedboard uses this macaddress: 00:e0:0c:00:98:03 

# if [ -f $(DTC) ]; then echo $(DTC); else make $(DTC); fi
INVOKE_DTC = $(DTC) -I dts -O dtb -o dtb.tmp imagefiles/zynq-$(BOARD)-portal.dts
dtb.tmp: imagefiles/zynq-$(BOARD)-portal.dts
	$(INVOKE_DTC) || make $(DTC); $(INVOKE_DTC)

zcomposite.elf: ramdisk dtb.tmp
	echo "******** PRINT GCC CONFIGURE OPTIONS *******"
	$(PREFIX)gcc -v 2>&1
	$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm imagefiles/zImage z.tmp
	$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm ramdisk.image.gz r.tmp
	$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm dtb.tmp d.tmp
	$(PREFIX)gcc -c -DBOARD_$(BOARD) -fno-unwind-tables clearreg.c
	$(PREFIX)ld -e 0x1008000 -z max-page-size=0x8000 -o zcomposite.elf --script zynq_linux_boot.lds r.tmp d.tmp clearreg.o z.tmp
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f z.tmp r.tmp d.tmp clearreg.o c1.tmp clearreg.o ramdisk.image.gz dtb.tmp
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

xbootgen: xbootgen.c Makefile reserved_for_interrupts.h
	gcc -g -o xbootgen xbootgen.c
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f reserved_for_interrupts.h
endif

dumpbootbin: dumpbootbin.c Makefile
	gcc -g -o dumpbootbin dumpbootbin.c

reserved_for_interrupts.h: reserved_for_interrupts.S
	$(PREFIX)gcc -c reserved_for_interrupts.S
	$(PREFIX)ld -Ttext 0 -e 0 -o i.tmp reserved_for_interrupts.o
	$(PREFIX)objcopy -O binary -I elf32-little i.tmp reserved_for_interrupts.tmp
	./bin2header.py reserved_for_interrupts.tmp >reserved_for_interrupts.h
ifeq ($(DELETE_TEMP_FILES),1)
	rm -f i.tmp reserved_for_interrupts.o reserved_for_interrupts.tmp
endif

zynqdrivers: zImage
	[ -d connectal ] || git clone git://github.com/cambridgehackers/connectal
	cd connectal; git pull origin master
	cd connectal; make zynqdrivers
	cp connectal/drivers/zynqportal/zynqportal.ko imagefiles
	cp connectal/drivers/portalmem/portalmem.ko imagefiles

zImage: bin/dtc
	cp linux-xlnx/arch/arm/boot/zImage imagefiles/zImage

real.sdcard: sdcard-$(BOARD)/system.img sdcard-$(BOARD)/userdata.img sdcard-$(BOARD)/boot.bin
	cp -v imagefiles/zynqportal.ko imagefiles/portalmem.ko imagefiles/timelimit imagefiles/webserver sdcard-$(BOARD)/
	[ -e sdcard-$(BOARD)/$(KERNELID) ] || mkdir sdcard-$(BOARD)/$(KERNELID)
	echo "Files for $(BOARD) SD Card are in $(PWD)/sdcard-$(BOARD)"

.PHONY: real.sdcard real.bootbin real.all real.zImage

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
	(cd sdcard-$(BOARD); $(MD5PROG) -c ../imagefiles/filesystems.md5sum)

ifeq ($(shell uname), Darwin)
sdcard-$(BOARD)/userdata.img: filesystems/userdata.img.bz2
	mkdir -p sdcard-$(BOARD)
	bzcat filesystems/userdata.img.bz2 > sdcard-$(BOARD)/userdata.img
else
sdcard-$(BOARD)/userdata.img:
	mkdir -p sdcard-$(BOARD)
	# make a 100MB empty filesystem
	dd if=/dev/zero bs=1k count=102400 of=sdcard-$(BOARD)/userdata.img
	$(MKFS) -F -t ext4 sdcard-$(BOARD)/userdata.img
endif

sdcard-zynq.zip:
	make all.zedboard
	mv sdcard-zedboard sdcard-zynq
	zip sdcard-zynq.zip sdcard-zynq/*.img sdcard-zynq/timelimit sdcard-zynq/webserver
	mv sdcard-zynq sdcard-zedboard

bootbin.zip:
	echo MACBYTE=$(MACBYTE)
	make all.zedboard
	rm -f boot.bin
	make MACBYTE=$(MACBYTE) bootbin.$(BOARD)
	mkdir bootbin-$(BOARD)
	mv -v boot.bin bootbin-$(BOARD)
	cp -v sdcard-zedboard/*.ko bootbin-$(BOARD)
	mkdir bootbin-$(BOARD)/$(KERNELID)
	zip bootbin-$(BOARD)-00e00c00$(MACBYTE)03.zip bootbin-$(BOARD)/*
	rm -fr bootbin-$(BOARD)

update-zynq-boot-filesystems:
	rm -f *.zip
	make sdcard-zynq.zip
	for b in zedboard zc702 zc706; do make BOARD=$$b bootbin.zip; done
	(cd ../zynq-boot-filesystems; git checkout --orphan v$(VERSION))
	cp *.zip ../zynq-boot-filesystems
	(cd ../zynq-boot-filesystems; git add *.zip; git commit -m "version $(VERSION)")

.PHONY: bin/dtc



bin/dtc:
	if [ -d linux-xlnx ]; then true; else git clone git://github.com/cambridgehackers/linux-xlnx.git; \
	     (cd linux-xlnx; git checkout origin/$(LINUX_KERNEL_BRANCH) -b $(LINUX_KERNEL_BRANCH)) fi
	(set -e; cd linux-xlnx; \
	git fetch; \
	git checkout $(LINUX_KERNEL_BRANCH); \
	git rebase origin/$(LINUX_KERNEL_BRANCH); \
	make ARCH=arm CROSS_COMPILE=$(KERNEL_CROSS) $(MACHEADERS) xilinx_zynq_portal_defconfig; \
	make ARCH=arm CROSS_COMPILE=$(KERNEL_CROSS) $(MACHEADERS) -j8 zImage; \
	make ARCH=arm CROSS_COMPILE=$(KERNEL_CROSS) $(MACHEADERS) M=scripts/dtc; \
	cp -fv scripts/dtc/dtc ../bin/dtc)

zImage-clean:
	if [ -d linux-xlnx ]; then true; else git clone git://github.com/cambridgehackers/linux-xlnx.git; fi
	(cd linux-xlnx; \
	make ARCH=arm CROSS_COMPILE=$(KERNEL_CROSS) $(MACHEADERS) clean)

webserver:
	if [ -d webui ]; then true; else git clone git://github.com/cambridgehackers/webui.git; fi
	cd webui; ndk-build
	cp webui/libs/armeabi/webserver imagefiles/webserver

parallella-boot:  ramdisk dtb.tmp
	# create ouput area
	mkdir -p parallella-images
	# device tree
	cp dtp.tmp parallella-images/dtb
	# kernel
	$(PREFIX)gcc -c -DBOARD_$(BOARD) -fno-unwind-tables clearreg.c
	$(PREFIX)ld -e 0x1008000 -O binary -z max-page-size=0x8000 -o zcomposite.elf --script zynq_linux_boot.lds clearreg.o z.tmp
	$(PREFIX)objcopy -O binary -B arm -o pImage c.tmp zImage

