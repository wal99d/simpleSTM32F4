.syntax unified
.cpu cortex-m4
.thumb

.section .text
.weak _reset 
.type _reset , %function
_reset:
	LDR SP, =_estack	
	#Base Address of RCC
        LDR R0, =0x40023800
	bl ClockConf
	bl main
	bx lr
.size _reset, . - _reset

.type ClockConf, %function
ClockConf:
	LDR R1, [R0, #0x0C]
	ORR R1, #0x800 /* Eneable HSERDY */
	STR R1, [R0, #0x0C]

	LDR R1, [R0]
	BIC R1, #0x40000 /*Clear HSEBPY Bit*/
	ORR R1, #0x10000 /*Set HSEON*/
	STR R1, [R0]
CC1:
	LDR R1, [R0]
	ANDS R1, #0x20000
	BEQ CC1	

	MOV R1, #1 /* Select HSE as SystemClk*/
	STR R1, [R0, #0x08]	
	bx lr
.size ClockConf, . - ClockConf

.section .interrupt_vector_table, "a", %progbits

.type basic_vector_table, %object

basic_vector_table:
	.word _estack
	.word _reset
	#.org 0x0000014C
	#.word _usb_otg

.size basic_vector_table,. - basic_vector_table
