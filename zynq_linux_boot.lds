
SECTIONS 
{
         .textr (0x800000): {
	     r.tmp(.data);
         }
         .textd (0x1000000): {
	     d.tmp(.data);
             . = . + 0x1000;
         }
         .textz (0x1008000): {
             start:
             clearreg.o(.text);
             clearreg.o(.rodata);
             _start_linux:
             z.tmp(.data);
         }
}
