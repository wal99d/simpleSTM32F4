
ENTRY(_reset)

MEMORY
{
RAM (xrw)      : ORIGIN = 0x20000000, LENGTH = 128K
FLASH (rx)      : ORIGIN = 0x8000000, LENGTH = 1024K
}

/* Highest address of the user mode stack */

_estack = 0x20020000; /* end of stack location */
_Min_Heap_Size = 0x200;      /* required amount of heap  */
_Min_Stack_Size = 0x400; /* required amount of stack */

SECTIONS
{
	.interrupt_vector_table : {*(.interrupt_vector_table)} >FLASH
	.text : {*(.text)} >FLASH
	.data : {*(.data)} >FLASH
	.bss : {
		__bss_start__ = .;
		*(.bss)
		__bss_end__ = .;
		} >RAM
	/* User_heap_stack section, used to check that there is enough RAM left */
  	._user_heap_stack :
  	{
    		. = ALIGN(8);
    		PROVIDE ( end = . );
    		PROVIDE ( _end = . );
    		. = . + _Min_Heap_Size;
    		. = . + _Min_Stack_Size;
    		. = ALIGN(8);
  	} >RAM	
}
