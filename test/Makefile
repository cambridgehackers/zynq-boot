
BOOTGEN=/scratch/Xilinx/SDK/2014.4/bin/bootgen
NDK_OBJDUMP=arm-none-linux-gnueabi-objdump
NDK_GCC=arm-none-linux-gnueabi-gcc
PREFIX=$(NDK_OBJDUMP:%-objdump=%-)

INT_FILES = xxdump0.elf xxdump1.elf xxdump2.elf xxdump3.elf
xxdump0.LOAD = 0
xxdump0.RUN = 0
xxdump1.LOAD = 0
xxdump1.RUN = 0
xxdump2.LOAD = 0x118000
xxdump2.RUN = 0x100000
xxdump3.LOAD = 0x100000
xxdump3.RUN = 0

SOURCEFILE ?= data/bootbase.bin

%.elf: %.dump
	$(PREFIX)objcopy -I binary -B arm -O elf32-littlearm $< --rename-section .data=.text tmpobj.o
	$(PREFIX)ld -e $($(patsubst %.dump,%.RUN, $<)) \
	    -z max-page-size=0x8000 \
	    --defsym=LOAD_ADDRESS=$($(patsubst %.dump,%.LOAD, $<)) \
	    --script convert.lds -o $@ tmpobj.o
	rm -f tmpobj.o

%.dump: tmpdumped
	@#echo

all: prep bootbase

prep:
	rm -f xxdump*.elf xxdump*.dump tmpdumped

bootbase: $(INT_FILES)
	#../../system-tools/elfdump/elfdump xxdump0.elf >xx0.dump
	rm -f testout.bin
	cp xxdump0.elf tmpfsbl.elf
	mv xxdump1.dump xxdump1.bin
	$(BOOTGEN) -o testout.bin -image testout.bif
	rm -f tmpfsbl.elf tmpdumped

tmpdumped: $(SOURCEFILE)
	../dumpbootbin $(SOURCEFILE) >xx.log
	touch tmpdumped

.PRECIOUS: $(INT_FILES:.elf=.dump)
