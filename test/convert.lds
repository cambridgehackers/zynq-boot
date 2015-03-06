
SECTIONS 
{
         .text (LOAD_ADDRESS): {
             start = .;
	     *(.text);
         }
}
