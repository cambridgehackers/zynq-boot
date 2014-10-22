#

ZBDIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BUILDDIR=$(shell pwd)

NDK_OBJDUMP=$(shell $(NDKPATH)ndk-which objdump)
NDK_GCC=$(shell $(NDKPATH)ndk-which gcc)
PREFIX=$(NDK_OBJDUMP:%-objdump=%-)
DTC=$(ZBDIR)/bin/dtc
KERNELID=3.9.0-00054-g7b6edac
DELETE_TEMP_FILES=1


targetnames = bootbin sdcard all

V=0
ifeq ($(V),0)
Q=@
VERBOSE_FLAG=
MKFS_Q=-q
else
Q=
VERBOSE_FLAG=--verbose
MKFS_Q=
endif


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
	$(Q)make -f $(ZBDIR)/Makefile BOARD=zedboard real.$(basename $@)
#################################################################################################
# zc702
zc702targets = $(addsuffix .zc702, $(targetnames))
zc702targets: $(zc702targets)
$(zc702targets):
	$(Q)make -f $(ZBDIR)/Makefile BOARD=zc702 real.$(basename $@)
#################################################################################################
# zc706
zc706targets = $(addsuffix .zc706, $(targetnames))
zc706targets: $(zc706targets)
$(zc706targets):
	$(Q)make -f $(ZBDIR)/Makefile BOARD=zc706 real.$(basename $@)
#################################################################################################
# miniitx100
miniitx100targets = $(addsuffix .miniitx100, $(targetnames))
miniitx100targets: $(miniitx100targets)
$(miniitx100targets):
	$(Q)make -f $(ZBDIR)/Makefile BOARD=miniitx100 real.$(basename $@)
#################################################################################################

real.all: real.bootbin real.sdcard

clean:
	@echo "make realclean" to remove downloaded files
	@echo cleaning
	$(Q)rm -fr sdcard-* boot.bin *.tmp *.elf *.gz *.hex *.o foo.map $(ZBDIR)/bin/* $(ZBDIR)/imagefiles/zImage $(ZBDIR)/imagefiles/*.ko

realclean: clean
	@echo cleaning filesystems
	$(Q)rm -fr $(ZBDIR)/filesystems/*

real.bootbin: zcomposite.elf $(ZBDIR)/imagefiles/zynq_$(BOARD)_fsbl.elf $(ZBDIR)/bin/xbootgen reserved_for_interrupts.tmp
	@echo making real.bootbin
	$(Q)if [ -f boot.bin ]; then mv -v boot.bin boot.bin.bak; fi
	$(Q)cp -vf $(ZBDIR)/imagefiles/zynq_$(BOARD)_fsbl.elf zynq_fsbl.elf
	$(Q)$(ZBDIR)/bin/xbootgen zynq_fsbl.elf zcomposite.elf
ifeq ($(DELETE_TEMP_FILES),1)
	$(Q)rm -f zynq_fsbl.elf zcomposite.elf reserved_for_interrupts.tmp
endif

dtb.tmp: $(ZBDIR)/imagefiles/zynq-$(BOARD)-portal.dts $(ZBDIR)/bin/dtc
	@echo making dtb.tmp
	$(Q)macbyte=`echo $(USER)$(BOARD) | md5sum | cut -c 1-2`; sed s/73/$$macbyte/ <$(ZBDIR)/imagefiles/zynq-$(BOARD)-portal.dts >dtswork.tmp
	@grep local-mac-address dtswork.tmp
	@echo compiling device tree
	$(Q)$(DTC) -I dts -O dtb -o dtb.tmp dtswork.tmp
ifeq ($(DELETE_TEMP_FILES),1)
	$(Q)rm -f dtswork.tmp
endif

zcomposite.elf: ramdisk dtb.tmp $(ZBDIR)/imagefiles/zImage
	@echo making zcomposite.elf
ifeq (V,1)
	echo "******** PRINT GCC CONFIGURE OPTIONS *******"
	$(PREFIX)gcc -v 2>&1
endif
	$(Q)$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm $(ZBDIR)/imagefiles/zImage z.tmp
	$(Q)$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm ramdisk.image.gz r.tmp
	$(Q)$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm dtb.tmp d.tmp
	$(Q)$(PREFIX)gcc -c $(ZBDIR)/clearreg.S
	$(Q)$(PREFIX)ld -z noexecstack -Ttext 0 -e 0 -o c.tmp clearreg.o
	$(Q)$(PREFIX)objcopy -I elf32-littlearm -O binary c.tmp c1.tmp
	$(Q)$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm c1.tmp c.tmp
	$(Q)$(PREFIX)ld -e 0x1008000 -z max-page-size=0x8000 -o zcomposite.elf --script $(ZBDIR)/zynq_linux_boot.lds r.tmp d.tmp c.tmp z.tmp
ifeq ($(DELETE_TEMP_FILES),1)
	$(Q)rm -f z.tmp r.tmp d.tmp c.tmp c1.tmp clearreg.o $(BUILDDIR)/ramdisk.image.gz dtb.tmp
endif

$(ZBDIR)/bin/canoncpio: $(ZBDIR)/canoncpio.c
	mkdir -p $(ZBDIR)/bin
	$(Q)gcc -o $(ZBDIR)/bin/canoncpio $(ZBDIR)/canoncpio.c

ramdisk: $(ZBDIR)/bin/canoncpio
	@echo making ramdisk
	@echo $(BUILDDIR) $(shell pwd)
	$(Q)chmod 644 $(ZBDIR)/data/*.rc $(ZBDIR)/data/*.prop
	$(Q)(cd $(ZBDIR)/data; find . -name unused -o -print | sort | cpio -H newc -o) >ramdisk.image.temp1
	$(Q)$(ZBDIR)/bin/canoncpio $(VERBOSE_FLAG) < ramdisk.image.temp1 | gzip -9 -n >ramdisk.image.temp
	$(Q)cat ramdisk.image.temp /dev/zero | dd of=ramdisk.image.gz count=256 ibs=1024 status=noxfer
ifeq ($(DELETE_TEMP_FILES),1)
	$(Q)rm -f ramdisk.image.temp ramdisk.image.temp1
endif

$(ZBDIR)/bin/xbootgen: $(ZBDIR)/xbootgen.c $(ZBDIR)/Makefile
	mkdir -p $(ZBDIR)/bin
	$(Q)gcc -g -o $(ZBDIR)/bin/xbootgen $(ZBDIR)/xbootgen.c

dumpbootbin: dumpbootbin.c Makefile
	$(Q)gcc -g -o dumpbootbin dumpbootbin.c

reserved_for_interrupts.tmp: $(ZBDIR)/reserved_for_interrupts.S
	$(Q)$(PREFIX)gcc -c $(ZBDIR)/reserved_for_interrupts.S
	$(Q)$(PREFIX)ld -Ttext 0 -e 0 -o i.tmp reserved_for_interrupts.o
	$(Q)$(PREFIX)objcopy -O binary -I elf32-little i.tmp reserved_for_interrupts.tmp
ifeq ($(DELETE_TEMP_FILES),1)
	$(Q)rm -f i.tmp reserved_for_interrupts.o
endif

real.sdcard: sdcard-$(BOARD)/system.img sdcard-$(BOARD)/userdata.img sdcard-$(BOARD)/boot.bin $(ZBDIR)/imagefiles/portalmem.ko $(ZBDIR)/imagefiles/zynqportal.ko
	$(Q)cp -v $(ZBDIR)/imagefiles/zynqportal.ko $(ZBDIR)/imagefiles/portalmem.ko $(ZBDIR)/imagefiles/timelimit sdcard-$(BOARD)/
	$(Q)[ -e sdcard-$(BOARD)/$(KERNELID) ] || mkdir sdcard-$(BOARD)/$(KERNELID)
	@echo "Files for $(BOARD) SD Card are in $(PWD)/sdcard-$(BOARD)"

.PHONY: real.sdcard real.bootbin real.all

sdcard-$(BOARD)/boot.bin:
	$(Q)mkdir -p sdcard-$(BOARD)
	$(Q)rm -f boot.bin
	$(Q)make -f $(ZBDIR)/Makefile BOARD=$(BOARD) real.bootbin
	$(Q)mv boot.bin sdcard-$(BOARD)/boot.bin

$(ZBDIR)/filesystems/system-130710.img.bz2:
	@echo downloading /system filesystem image
	$(Q)mkdir -p $(ZBDIR)/filesystems
	$(Q)wget 'https://github.com/cambridgehackers/zynq-boot-filesystems/blob/system-130710/system-130710.img.bz2?raw=true' -O $(ZBDIR)/filesystems/system-130710.img.bz2

$(ZBDIR)/filesystems/userdata.img.bz2:
	@echo downloading /data filesystem image
	$(Q)mkdir -p $(ZBDIR)/filesystems
	$(Q)wget 'https://github.com/cambridgehackers/zynq-boot-filesystems/blob/userdata/userdata.img.bz2?raw=true' -O $(ZBDIR)/filesystems/userdata.img.bz2

sdcard-$(BOARD)/system.img: $(ZBDIR)/filesystems/system-130710.img.bz2
	@echo uncompressing /system filesystme image
	$(Q)mkdir -p sdcard-$(BOARD)
	$(Q)bzcat $(ZBDIR)/filesystems/system-130710.img.bz2 > sdcard-$(BOARD)/system.img
	$(Q)(cd sdcard-$(BOARD); md5sum -c $(ZBDIR)/imagefiles/filesystems.md5sum)

ifeq ($(shell uname), Darwin)
sdcard-$(BOARD)/userdata.img: $(ZBDIR)/filesystems/userdata.img.bz2
	@echo uncompressing /data filesystem image
	$(Q)mkdir -p sdcard-$(BOARD)
	$(Q)bzcat $(ZBDIR)/filesystems/userdata.img.bz2 > sdcard-$(BOARD)/userdata.img
else
sdcard-$(BOARD)/userdata.img:
	@echo making empty /data filesystem image
	$(Q)mkdir -p sdcard-$(BOARD)
	# make a 100MB empty filesystem
	$(Q)dd if=/dev/zero bs=1k count=102400 of=sdcard-$(BOARD)/userdata.img status=noxfer
	$(Q)mkfs $(MKFS_Q) -F -t ext4 sdcard-$(BOARD)/userdata.img
endif

$(ZBDIR)/linux-xlnx/arch/arm/boot/zImage:
	@echo checking out xilinx linux kernel
	$(Q)if [ -d linux-xlnx ]; then true; else git clone git://github.com/cambridgehackers/linux-xlnx.git; fi
	@echo building dtc
	$(Q)(cd linux-xlnx; \
	git checkout remotes/origin/xbsv-2014.04 -b xbsv-2014.04; \
	make ARCH=arm CROSS_COMPILE=$(PREFIX) xilinx_zynq_portal_defconfig; \
	make ARCH=arm CROSS_COMPILE=$(PREFIX) -j8 zImage modules; \
	make ARCH=arm CROSS_COMPILE=$(PREFIX) M=scripts/dtc )

$(ZBDIR)/imagefiles/portalmem.ko: $(ZBDIR)/linux-xlnx/arch/arm/boot/zImage
	@echo checking out connectal
	$(Q)if [ -d connectal ]; then true; else git clone git://github.com/cambridgehackers/connectal.git; fi
	@echo building zynqdrivers $(PREFIX)
	$(Q)(cd connectal/; \
	make DEVICE_XILINX_KERNEL=$(ZBDIR)/linux-xlnx CROSS_COMPILE=$(PREFIX) zynqdrivers )
	cp -fv connectal/drivers/portalmem/portalmem.ko $(ZBDIR)/imagefiles/
	cp -fv connectal/drivers/zynqportal/zynqportal.ko $(ZBDIR)/imagefiles/

$(ZBDIR)/imagefiles/zynqportal.ko: $(ZBDIR)/imagefiles/portalmem.ko

$(ZBDIR)/imagefiles/zImage: $(ZBDIR)/linux-xlnx/arch/arm/boot/zImage
	cp -fv linux-xlnx/arch/arm/boot/zImage $(ZBDIR)/imagefiles/zImage

$(ZBDIR)/bin/dtc: $(ZBDIR)/linux-xlnx/arch/arm/boot/zImage
	mkdir -p $(ZBDIR)/bin
	$(Q)cp -fv linux-xlnx/scripts/dtc/dtc $(ZBDIR)/bin/dtc
