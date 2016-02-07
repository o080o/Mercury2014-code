opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 9453"

opt pagewidth 120

	opt lm

	processor	16F877A
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 6 "C:\git\Mercury2014-code\mercury2014_PIC_code\main.c"
	psect config,class=CONFIG,delta=2 ;#
# 6 "C:\git\Mercury2014-code\mercury2014_PIC_code\main.c"
	dw 0xFFFD & 0xFFFB & 0xFFFF & 0xFFBF & 0xFFFF & 0xFFFF & 0xF7FF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,_init_usart
	FNCALL	_main,_printf
	FNCALL	_main,_motor_controller_test
	FNCALL	_motor_controller_test,_phase
	FNCALL	_phase,___awmod
	FNCALL	_printf,_putch
	FNCALL	_printf,___lwdiv
	FNCALL	_printf,___lwmod
	FNROOT	_main
	global	_leadAHighL
	global	_leadAHighR
	global	_leadALowL
	global	_leadALowR
	global	_leadBHighL
	global	_leadBHighR
	global	_leadBLowL
	global	_leadBLowR
	global	_leadCHighL
	global	_leadCHighR
	global	_leadCLowL
	global	_leadCLowR
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	12

;initializer for _leadAHighL
	retlw	01h
	retlw	0

	line	6

;initializer for _leadAHighR
	retlw	04h
	retlw	0

	line	13

;initializer for _leadALowL
	retlw	02h
	retlw	0

	line	7

;initializer for _leadALowR
	retlw	08h
	retlw	0

	line	14

;initializer for _leadBHighL
	retlw	04h
	retlw	0

	line	8

;initializer for _leadBHighR
	retlw	010h
	retlw	0

	line	15

;initializer for _leadBLowL
	retlw	08h
	retlw	0

	line	9

;initializer for _leadBLowR
	retlw	020h
	retlw	0

	line	16

;initializer for _leadCHighL
	retlw	010h
	retlw	0

	line	10

;initializer for _leadCHighR
	retlw	040h
	retlw	0

	line	17

;initializer for _leadCLowL
	retlw	020h
	retlw	0

	line	11

;initializer for _leadCLowR
	retlw	080h
	retlw	0

	global	_dpowers
psect	strings,class=STRING,delta=2
global __pstrings
__pstrings:
;	global	stringdir,stringtab,__stringbase
stringtab:
;	String table - string pointers are 1 byte each
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
__stringbase:
	retlw	0
psect	strings
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.82\lib\doprnt.c"
	line	350
_dpowers:
	retlw	01h
	retlw	0

	retlw	0Ah
	retlw	0

	retlw	064h
	retlw	0

	retlw	0E8h
	retlw	03h

	retlw	010h
	retlw	027h

	global	_dpowers
	global	_ADCON0
_ADCON0	set	31
	global	_RCREG
_RCREG	set	26
	global	_RCSTA
_RCSTA	set	24
	global	_TXREG
_TXREG	set	25
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_RB0
_RB0	set	48
	global	_RB1
_RB1	set	49
	global	_RB2
_RB2	set	50
	global	_RB4
_RB4	set	52
	global	_RB5
_RB5	set	53
	global	_RCIF
_RCIF	set	101
	global	_RD0
_RD0	set	64
	global	_RD1
_RD1	set	65
	global	_RD2
_RD2	set	66
	global	_RD3
_RD3	set	67
	global	_RD4
_RD4	set	68
	global	_RD5
_RD5	set	69
	global	_RD6
_RD6	set	70
	global	_RD7
_RD7	set	71
	global	_TXIF
_TXIF	set	100
	global	_ADCON1
_ADCON1	set	159
	global	_ADRESL
_ADRESL	set	158
	global	_SPBRG
_SPBRG	set	153
	global	_TRISB
_TRISB	set	134
	global	_TRISD
_TRISD	set	136
	global	_TXSTA
_TXSTA	set	152
	global	_TRISC6
_TRISC6	set	1086
	global	_TRISC7
_TRISC7	set	1087
	global	_EEADR
_EEADR	set	269
	global	_EEDATA
_EEDATA	set	268
	global	_EECON1
_EECON1	set	396
	global	_EECON2
_EECON2	set	397
	global	_RD
_RD	set	3168
	global	_WR
_WR	set	3169
	global	_WREN
_WREN	set	3170
	
STR_1:	
	retlw	72	;'H'
	retlw	101	;'e'
	retlw	108	;'l'
	retlw	108	;'l'
	retlw	111	;'o'
	retlw	33	;'!'
	retlw	0
psect	strings
	
STR_2:	
	retlw	37	;'%'
	retlw	100	;'d'
	retlw	0
psect	strings
	file	"mercury2014_PIC_code.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	12
_leadAHighL:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	6
_leadAHighR:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	13
_leadALowL:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	7
_leadALowR:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	14
_leadBHighL:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	8
_leadBHighR:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	15
_leadBLowL:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	9
_leadBLowR:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	16
_leadCHighL:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	10
_leadCHighR:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	17
_leadCLowL:
       ds      2

psect	dataBANK0
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	11
_leadCLowR:
       ds      2

global btemp
psect inittext,class=CODE,delta=2
global init_fetch,btemp
;	Called with low address in FSR and high address in W
init_fetch:
	movf btemp,w
	movwf pclath
	movf btemp+1,w
	movwf pc
global init_ram
;Called with:
;	high address of idata address in btemp 
;	low address of idata address in btemp+1 
;	low address of data in FSR
;	high address + 1 of data in btemp-1
init_ram:
	fcall init_fetch
	movwf indf,f
	incf fsr,f
	movf fsr,w
	xorwf btemp-1,w
	btfsc status,2
	retlw 0
	incf btemp+1,f
	btfsc status,2
	incf btemp,f
	goto init_ram
; Initialize objects allocated to BANK0
psect cinit,class=CODE,delta=2
global init_ram, __pidataBANK0
	bcf	status, 7	;select IRP bank0
	movlw low(__pdataBANK0+24)
	movwf btemp-1,f
	movlw high(__pidataBANK0)
	movwf btemp,f
	movlw low(__pidataBANK0)
	movwf btemp+1,f
	movlw low(__pdataBANK0)
	movwf fsr,f
	fcall init_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_putch
?_putch:	; 0 bytes @ 0x0
	global	??_putch
??_putch:	; 0 bytes @ 0x0
	global	?_init_usart
?_init_usart:	; 0 bytes @ 0x0
	global	??_init_usart
??_init_usart:	; 0 bytes @ 0x0
	global	?_motor_controller_test
?_motor_controller_test:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 2 bytes @ 0x0
	global	?___lwdiv
?___lwdiv:	; 2 bytes @ 0x0
	global	?___awmod
?___awmod:	; 2 bytes @ 0x0
	global	putch@input
putch@input:	; 1 bytes @ 0x0
	global	___lwdiv@divisor
___lwdiv@divisor:	; 2 bytes @ 0x0
	global	___awmod@divisor
___awmod@divisor:	; 2 bytes @ 0x0
	ds	2
	global	___lwdiv@dividend
___lwdiv@dividend:	; 2 bytes @ 0x2
	global	___awmod@dividend
___awmod@dividend:	; 2 bytes @ 0x2
	ds	2
	global	??___lwdiv
??___lwdiv:	; 0 bytes @ 0x4
	global	??___awmod
??___awmod:	; 0 bytes @ 0x4
	ds	1
	global	___awmod@counter
___awmod@counter:	; 1 bytes @ 0x5
	global	___lwdiv@quotient
___lwdiv@quotient:	; 2 bytes @ 0x5
	ds	1
	global	___awmod@sign
___awmod@sign:	; 1 bytes @ 0x6
	ds	1
	global	?_phase
?_phase:	; 0 bytes @ 0x7
	global	___lwdiv@counter
___lwdiv@counter:	; 1 bytes @ 0x7
	global	phase@p
phase@p:	; 2 bytes @ 0x7
	ds	1
	global	?___lwmod
?___lwmod:	; 2 bytes @ 0x8
	global	___lwmod@divisor
___lwmod@divisor:	; 2 bytes @ 0x8
	ds	1
	global	phase@motor
phase@motor:	; 1 bytes @ 0x9
	ds	1
	global	??_motor_controller_test
??_motor_controller_test:	; 0 bytes @ 0xA
	global	??_phase
??_phase:	; 0 bytes @ 0xA
	global	___lwmod@dividend
___lwmod@dividend:	; 2 bytes @ 0xA
	ds	2
	global	??___lwmod
??___lwmod:	; 0 bytes @ 0xC
	global	motor_controller_test@p
motor_controller_test@p:	; 2 bytes @ 0xC
	ds	1
	global	___lwmod@counter
___lwmod@counter:	; 1 bytes @ 0xD
	ds	1
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	?_printf
?_printf:	; 2 bytes @ 0x0
	ds	2
	global	??_printf
??_printf:	; 0 bytes @ 0x2
	ds	3
	global	printf@ap
printf@ap:	; 1 bytes @ 0x5
	ds	1
	global	printf@flag
printf@flag:	; 1 bytes @ 0x6
	ds	1
	global	printf@f
printf@f:	; 1 bytes @ 0x7
	ds	1
	global	printf@prec
printf@prec:	; 1 bytes @ 0x8
	ds	1
	global	printf@_val
printf@_val:	; 4 bytes @ 0x9
	ds	4
	global	printf@c
printf@c:	; 1 bytes @ 0xD
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0xE
	ds	3
	global	main@i
main@i:	; 2 bytes @ 0x11
	ds	2
;;Data sizes: Strings 10, constant 10, data 24, bss 0, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14     14      14
;; BANK0           80     19      43
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; ?___lwdiv	unsigned int  size(1) Largest target is 0
;;
;; ?___lwmod	unsigned int  size(1) Largest target is 0
;;
;; ?___awmod	int  size(1) Largest target is 0
;;
;; printf@f	PTR const unsigned char  size(1) Largest target is 7
;;		 -> STR_2(CODE[3]), STR_1(CODE[7]), 
;;
;; ?_printf	int  size(1) Largest target is 0
;;
;; printf@ap	PTR void [1] size(1) Largest target is 2
;;		 -> ?_printf(BANK0[2]), 
;;
;; S3788$_cp	PTR const unsigned char  size(1) Largest target is 0
;;
;; _val._str._cp	PTR const unsigned char  size(1) Largest target is 0
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _main->_motor_controller_test
;;   _motor_controller_test->_phase
;;   _phase->___awmod
;;   _printf->___lwmod
;;   ___lwmod->___lwdiv
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_printf
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 3, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 5     5      0    1316
;;                                             14 BANK0      5     5      0
;;                         _init_usart
;;                             _printf
;;              _motor_controller_test
;; ---------------------------------------------------------------------------------
;; (1) _motor_controller_test                                4     4      0     540
;;                                             10 COMMON     4     4      0
;;                              _phase
;; ---------------------------------------------------------------------------------
;; (2) _phase                                                3     0      3     495
;;                                              7 COMMON     3     0      3
;;                            ___awmod
;; ---------------------------------------------------------------------------------
;; (1) _printf                                              14    12      2     729
;;                                              0 BANK0     14    12      2
;;                              _putch
;;                            ___lwdiv
;;                            ___lwmod
;; ---------------------------------------------------------------------------------
;; (3) ___awmod                                              7     3      4     296
;;                                              0 COMMON     7     3      4
;; ---------------------------------------------------------------------------------
;; (2) ___lwmod                                              6     2      4     159
;;                                              8 COMMON     6     2      4
;;                            ___lwdiv (ARG)
;; ---------------------------------------------------------------------------------
;; (2) ___lwdiv                                              8     4      4     162
;;                                              0 COMMON     8     4      4
;; ---------------------------------------------------------------------------------
;; (1) _init_usart                                           0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _putch                                                1     1      0      22
;;                                              0 COMMON     1     1      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 3
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _init_usart
;;   _printf
;;     _putch
;;     ___lwdiv
;;     ___lwmod
;;       ___lwdiv (ARG)
;;   _motor_controller_test
;;     _phase
;;       ___awmod
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BANK3               60      0       0       9        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;BANK2               60      0       0      11        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;CODE                 0      0       0       0        0.0%
;;DATA                 0      0      3C      12        0.0%
;;ABS                  0      0      39       3        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       3       2        0.0%
;;BANK0               50     13      2B       5       53.8%
;;BITBANK0            50      0       0       4        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      E       E       1      100.0%
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 15 in file "C:\git\Mercury2014-code\mercury2014_PIC_code\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               2   17[BANK0 ] int 
;; Return value:  Size  Location     Type
;;                  2  697[COMMON] int 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       2       0       0       0
;;      Temps:          0       3       0       0       0
;;      Totals:         0       5       0       0       0
;;Total ram usage:        5 bytes
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_init_usart
;;		_printf
;;		_motor_controller_test
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\main.c"
	line	15
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 5
; Regs used in _main: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
	line	17
	
l5173:	
;main.c: 17: TRISB &= 0b11111110;
	movlw	(0FEh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	andwf	(134)^080h,f	;volatile
	line	18
	
l5175:	
;main.c: 18: RB0 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(48/8),(48)&7
	line	20
	
l5177:	
;main.c: 20: TRISD = 0b00000000;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(136)^080h	;volatile
	line	21
	
l5179:	
;main.c: 21: init_usart();
	fcall	_init_usart
	line	22
	
l5181:	
;main.c: 22: printf("Hello!");
	movlw	((STR_1-__stringbase))&0ffh
	fcall	_printf
	line	24
	
l5183:	
;main.c: 24: int i = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(main@i)
	clrf	(main@i+1)
	line	25
	
l5185:	
;main.c: 25: for (i = 0; i < 2; i++){
	clrf	(main@i)
	clrf	(main@i+1)
	
l5187:	
	movf	(main@i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(02h))^80h
	subwf	btemp+1,w
	skipz
	goto	u3065
	movlw	low(02h)
	subwf	(main@i),w
u3065:

	skipc
	goto	u3061
	goto	u3060
u3061:
	goto	l698
u3060:
	goto	l5197
	
l5189:	
	goto	l5197
	
l698:	
	line	26
;main.c: 26: RB0 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(48/8),(48)&7
	line	27
	
l5191:	
;main.c: 27: _delay((unsigned long)((1000)*(4000000/4000.0)));
	opt asmopt_off
movlw  6
movwf	((??_main+0)+0+2),f
movlw	19
movwf	((??_main+0)+0+1),f
	movlw	177
movwf	((??_main+0)+0),f
u3087:
	decfsz	((??_main+0)+0),f
	goto	u3087
	decfsz	((??_main+0)+0+1),f
	goto	u3087
	decfsz	((??_main+0)+0+2),f
	goto	u3087
	nop2
opt asmopt_on

	line	28
	
l5193:	
;main.c: 28: RB0 = 1;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(48/8),(48)&7
	line	29
;main.c: 29: _delay((unsigned long)((1000)*(4000000/4000.0)));
	opt asmopt_off
movlw  6
movwf	((??_main+0)+0+2),f
movlw	19
movwf	((??_main+0)+0+1),f
	movlw	177
movwf	((??_main+0)+0),f
u3097:
	decfsz	((??_main+0)+0),f
	goto	u3097
	decfsz	((??_main+0)+0+1),f
	goto	u3097
	decfsz	((??_main+0)+0+2),f
	goto	u3097
	nop2
opt asmopt_on

	line	25
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(main@i),f
	skipnc
	incf	(main@i+1),f
	movlw	high(01h)
	addwf	(main@i+1),f
	
l5195:	
	movf	(main@i+1),w
	xorlw	80h
	movwf	btemp+1
	movlw	(high(02h))^80h
	subwf	btemp+1,w
	skipz
	goto	u3075
	movlw	low(02h)
	subwf	(main@i),w
u3075:

	skipc
	goto	u3071
	goto	u3070
u3071:
	goto	l698
u3070:
	goto	l5197
	
l699:	
	line	32
	
l5197:	
;main.c: 30: }
;main.c: 32: motor_controller_test();
	fcall	_motor_controller_test
	goto	l700
	line	62
	
l5199:	
	line	63
;main.c: 62: return 0;
;	Return value of _main is never used
	
l700:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,90
	global	_motor_controller_test
psect	text232,local,class=CODE,delta=2
global __ptext232
__ptext232:

;; *************** function _motor_controller_test *****************
;; Defined at:
;;		line 41 in file "C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  p               2   12[COMMON] unsigned int 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         2       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         4       0       0       0       0
;;Total ram usage:        4 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_phase
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text232
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	41
	global	__size_of_motor_controller_test
	__size_of_motor_controller_test	equ	__end_of_motor_controller_test-_motor_controller_test
	
_motor_controller_test:	
	opt	stack 5
; Regs used in _motor_controller_test: [wreg+status,2+status,0+pclath+cstack]
	line	51
	
l5165:	
;motor_control.c: 51: unsigned int p=0;
	clrf	(motor_controller_test@p)
	clrf	(motor_controller_test@p+1)
	goto	l5167
	line	52
;motor_control.c: 52: while( 1 ){
	
l1416:	
	line	53
	
l5167:	
;motor_control.c: 53: phase(p, 0);
	movf	(motor_controller_test@p+1),w
	clrf	(?_phase+1)
	addwf	(?_phase+1)
	movf	(motor_controller_test@p),w
	clrf	(?_phase)
	addwf	(?_phase)

	clrf	0+(?_phase)+02h
	fcall	_phase
	line	54
	
l5169:	
;motor_control.c: 54: phase(p, 1);
	movf	(motor_controller_test@p+1),w
	clrf	(?_phase+1)
	addwf	(?_phase+1)
	movf	(motor_controller_test@p),w
	clrf	(?_phase)
	addwf	(?_phase)

	clrf	0+(?_phase)+02h
	bsf	status,0
	rlf	0+(?_phase)+02h,f
	fcall	_phase
	line	56
	
l5171:	
;motor_control.c: 56: _delay((unsigned long)((5)*(4000000/4000.0)));
	opt asmopt_off
movlw	7
movwf	((??_motor_controller_test+0)+0+1),f
	movlw	125
movwf	((??_motor_controller_test+0)+0),f
u3107:
	decfsz	((??_motor_controller_test+0)+0),f
	goto	u3107
	decfsz	((??_motor_controller_test+0)+0+1),f
	goto	u3107
opt asmopt_on

	goto	l5167
	line	57
	
l1417:	
	line	52
	goto	l5167
	
l1418:	
	line	59
	
l1419:	
	return
	opt stack 0
GLOBAL	__end_of_motor_controller_test
	__end_of_motor_controller_test:
;; =============== function _motor_controller_test ends ============

	signat	_motor_controller_test,88
	global	_phase
psect	text233,local,class=CODE,delta=2
global __ptext233
__ptext233:

;; *************** function _phase *****************
;; Defined at:
;;		line 62 in file "C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
;; Parameters:    Size  Location     Type
;;  p               2    7[COMMON] int 
;;  motor           1    9[COMMON] unsigned char 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         3       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         3       0       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		___awmod
;; This function is called by:
;;		_motor_controller_test
;; This function uses a non-reentrant model
;;
psect	text233
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\motor_control.c"
	line	62
	global	__size_of_phase
	__size_of_phase	equ	__end_of_phase-_phase
	
_phase:	
	opt	stack 5
; Regs used in _phase: [wreg+status,2+status,0+pclath+cstack]
	line	63
	
l5135:	
;motor_control.c: 63: p = p % 3;
	movlw	low(03h)
	movwf	(?___awmod)
	movlw	high(03h)
	movwf	((?___awmod))+1
	movf	(phase@p+1),w
	clrf	1+(?___awmod)+02h
	addwf	1+(?___awmod)+02h
	movf	(phase@p),w
	clrf	0+(?___awmod)+02h
	addwf	0+(?___awmod)+02h

	fcall	___awmod
	movf	(1+(?___awmod)),w
	clrf	(phase@p+1)
	addwf	(phase@p+1)
	movf	(0+(?___awmod)),w
	clrf	(phase@p)
	addwf	(phase@p)

	line	64
	
l5137:	
;motor_control.c: 64: if (motor == 0) {
	movf	(phase@motor),f
	skipz
	goto	u2861
	goto	u2860
u2861:
	goto	l5151
u2860:
	line	65
	
l5139:	
;motor_control.c: 65: if (p == 0)
	movf	((phase@p+1)),w
	iorwf	((phase@p)),w
	skipz
	goto	u2871
	goto	u2870
u2871:
	goto	l5143
u2870:
	line	67
	
l5141:	
;motor_control.c: 66: {
;motor_control.c: 67: RD5 = RD3 = RD6 = RD2 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(66/8),(66)&7
	bcf	(70/8),(70)&7
	bcf	(67/8),(67)&7
	bcf	(69/8),(69)&7
	line	68
;motor_control.c: 68: RD7 = RD4 = 1;
	bsf	(68/8),(68)&7
	btfsc	(68/8),(68)&7
	goto	u2881
	goto	u2880
	
u2881:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(71/8),(71)&7
	goto	u2894
u2880:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(71/8),(71)&7
u2894:
	line	69
;motor_control.c: 69: }
	goto	l1435
	line	70
	
l1423:	
	
l5143:	
;motor_control.c: 70: else if (p == 1)
	movlw	01h
	xorwf	(phase@p),w
	iorwf	(phase@p+1),w
	skipz
	goto	u2901
	goto	u2900
u2901:
	goto	l5147
u2900:
	line	72
	
l5145:	
;motor_control.c: 71: {
;motor_control.c: 72: RD7 = RD3 = RD6 = RD4 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(68/8),(68)&7
	bcf	(70/8),(70)&7
	bcf	(67/8),(67)&7
	bcf	(71/8),(71)&7
	line	73
;motor_control.c: 73: RD5 = RD2 = 1;
	bsf	(66/8),(66)&7
	btfsc	(66/8),(66)&7
	goto	u2911
	goto	u2910
	
u2911:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(69/8),(69)&7
	goto	u2924
u2910:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(69/8),(69)&7
u2924:
	line	74
;motor_control.c: 74: }
	goto	l1435
	line	75
	
l1425:	
	
l5147:	
;motor_control.c: 75: else if (p == 2)
	movlw	02h
	xorwf	(phase@p),w
	iorwf	(phase@p+1),w
	skipz
	goto	u2931
	goto	u2930
u2931:
	goto	l1435
u2930:
	line	77
	
l5149:	
;motor_control.c: 76: {
;motor_control.c: 77: RD7 = RD5 = RD4 = RD2 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(66/8),(66)&7
	bcf	(68/8),(68)&7
	bcf	(69/8),(69)&7
	bcf	(71/8),(71)&7
	line	78
;motor_control.c: 78: RD3 = RD6 = 1;
	bsf	(70/8),(70)&7
	btfsc	(70/8),(70)&7
	goto	u2941
	goto	u2940
	
u2941:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(67/8),(67)&7
	goto	u2954
u2940:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(67/8),(67)&7
u2954:
	goto	l1435
	line	79
	
l1427:	
	goto	l1435
	line	80
	
l1426:	
	goto	l1435
	
l1424:	
;motor_control.c: 79: }
;motor_control.c: 80: }
	goto	l1435
	line	81
	
l1422:	
	
l5151:	
;motor_control.c: 81: else if (motor == 1) {
	movf	(phase@motor),w
	xorlw	01h
	skipz
	goto	u2961
	goto	u2960
u2961:
	goto	l1435
u2960:
	line	82
	
l5153:	
;motor_control.c: 82: if (p == 0)
	movf	((phase@p+1)),w
	iorwf	((phase@p)),w
	skipz
	goto	u2971
	goto	u2970
u2971:
	goto	l5157
u2970:
	line	84
	
l5155:	
;motor_control.c: 83: {
;motor_control.c: 84: RB1 = RB4 = RD1 = RB5 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(53/8),(53)&7
	bcf	(65/8),(65)&7
	bcf	(52/8),(52)&7
	bcf	(49/8),(49)&7
	line	85
;motor_control.c: 85: RD0 = RB2 = 1;
	bsf	(50/8),(50)&7
	btfsc	(50/8),(50)&7
	goto	u2981
	goto	u2980
	
u2981:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(64/8),(64)&7
	goto	u2994
u2980:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(64/8),(64)&7
u2994:
	line	86
;motor_control.c: 86: }
	goto	l1435
	line	87
	
l1430:	
	
l5157:	
;motor_control.c: 87: else if (p == 1)
	movlw	01h
	xorwf	(phase@p),w
	iorwf	(phase@p+1),w
	skipz
	goto	u3001
	goto	u3000
u3001:
	goto	l5161
u3000:
	line	89
	
l5159:	
;motor_control.c: 88: {
;motor_control.c: 89: RD0 = RB4 = RD1 = RB2 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(50/8),(50)&7
	bcf	(65/8),(65)&7
	bcf	(52/8),(52)&7
	bcf	(64/8),(64)&7
	line	90
;motor_control.c: 90: RB1 = RB5 = 1;
	bsf	(53/8),(53)&7
	btfsc	(53/8),(53)&7
	goto	u3011
	goto	u3010
	
u3011:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(49/8),(49)&7
	goto	u3024
u3010:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(49/8),(49)&7
u3024:
	line	91
;motor_control.c: 91: }
	goto	l1435
	line	92
	
l1432:	
	
l5161:	
;motor_control.c: 92: else if (p == 2)
	movlw	02h
	xorwf	(phase@p),w
	iorwf	(phase@p+1),w
	skipz
	goto	u3031
	goto	u3030
u3031:
	goto	l1435
u3030:
	line	94
	
l5163:	
;motor_control.c: 93: {
;motor_control.c: 94: RD0 = RB1 = RB2 = RB5 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(53/8),(53)&7
	bcf	(50/8),(50)&7
	bcf	(49/8),(49)&7
	bcf	(64/8),(64)&7
	line	95
;motor_control.c: 95: RB4 = RD1 = 1;
	bsf	(65/8),(65)&7
	btfsc	(65/8),(65)&7
	goto	u3041
	goto	u3040
	
u3041:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(52/8),(52)&7
	goto	u3054
u3040:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(52/8),(52)&7
u3054:
	goto	l1435
	line	96
	
l1434:	
	goto	l1435
	line	97
	
l1433:	
	goto	l1435
	
l1431:	
	goto	l1435
	
l1429:	
	goto	l1435
	line	98
	
l1428:	
	
l1435:	
	return
	opt stack 0
GLOBAL	__end_of_phase
	__end_of_phase:
;; =============== function _phase ends ============

	signat	_phase,8312
	global	_printf
psect	text234,local,class=CODE,delta=2
global __ptext234
__ptext234:

;; *************** function _printf *****************
;; Defined at:
;;		line 461 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.82\lib\doprnt.c"
;; Parameters:    Size  Location     Type
;;  f               1    wreg     PTR const unsigned char 
;;		 -> STR_2(3), STR_1(7), 
;; Auto vars:     Size  Location     Type
;;  f               1    7[BANK0 ] PTR const unsigned char 
;;		 -> STR_2(3), STR_1(7), 
;;  _val            4    9[BANK0 ] struct .
;;  c               1   13[BANK0 ] char 
;;  prec            1    8[BANK0 ] char 
;;  flag            1    6[BANK0 ] unsigned char 
;;  ap              1    5[BANK0 ] PTR void [1]
;;		 -> ?_printf(2), 
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] int 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, btemp+1, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       2       0       0       0
;;      Locals:         0       9       0       0       0
;;      Temps:          0       3       0       0       0
;;      Totals:         0      14       0       0       0
;;Total ram usage:       14 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_putch
;;		___lwdiv
;;		___lwmod
;; This function is called by:
;;		_main
;;		_sensor_test
;; This function uses a non-reentrant model
;;
psect	text234
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\doprnt.c"
	line	461
	global	__size_of_printf
	__size_of_printf	equ	__end_of_printf-_printf
	
_printf:	
	opt	stack 6
; Regs used in _printf: [wreg-fsr0h+status,2+status,0+btemp+1+pclath+cstack]
;printf@f stored from wreg
	line	537
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(printf@f)
	
l5087:	
	movlw	(?_printf)&0ffh
	movwf	(??_printf+0)+0
	movf	(??_printf+0)+0,w
	movwf	(printf@ap)
	line	540
	goto	l5133
	
l2850:	
	line	542
	
l5089:	
	movf	(printf@c),w
	xorlw	025h
	skipnz
	goto	u2781
	goto	u2780
u2781:
	goto	l2851
u2780:
	line	545
	
l5091:	
	movf	(printf@c),w
	fcall	_putch
	line	546
	goto	l5133
	line	547
	
l2851:	
	line	552
	clrf	(printf@flag)
	line	638
	goto	l5095
	line	640
	
l2853:	
	line	641
	goto	l2868
	line	700
	
l2855:	
	goto	l5097
	line	701
	
l2856:	
	line	702
	goto	l5097
	line	805
	
l2858:	
	line	816
	goto	l5133
	line	825
	
l5093:	
	goto	l5097
	line	638
	
l2852:	
	
l5095:	
	movlw	01h
	addwf	(printf@f),f
	movlw	-01h
	addwf	(printf@f),w
	movwf	fsr0
	fcall	stringdir
	movwf	(printf@c)
	; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 0 to 105
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; jumptable            260     6 (fixed)
; rangetable           110     6 (fixed)
; spacedrange          218     9 (fixed)
; locatedrange         106     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l2868
	xorlw	100^0	; case 100
	skipnz
	goto	l5097
	xorlw	105^100	; case 105
	skipnz
	goto	l5097
	goto	l5133
	opt asmopt_on

	line	825
	
l2857:	
	line	1254
	
l5097:	
	movf	(printf@ap),w
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	movwf	(printf@_val)
	incf	fsr0,f
	movf	indf,w
	movwf	(printf@_val+1)
	
l5099:	
	movlw	(02h)
	movwf	(??_printf+0)+0
	movf	(??_printf+0)+0,w
	addwf	(printf@ap),f
	line	1256
	
l5101:	
	btfss	(printf@_val+1),7
	goto	u2791
	goto	u2790
u2791:
	goto	l5107
u2790:
	line	1257
	
l5103:	
	movlw	(03h)
	movwf	(??_printf+0)+0
	movf	(??_printf+0)+0,w
	iorwf	(printf@flag),f
	line	1258
	
l5105:	
	comf	(printf@_val),f
	comf	(printf@_val+1),f
	incf	(printf@_val),f
	skipnz
	incf	(printf@_val+1),f
	goto	l5107
	line	1259
	
l2859:	
	line	1300
	
l5107:	
	clrf	(printf@c)
	bsf	status,0
	rlf	(printf@c),f
	
l5109:	
	movf	(printf@c),w
	xorlw	05h
	skipz
	goto	u2801
	goto	u2800
u2801:
	goto	l5113
u2800:
	goto	l5121
	
l5111:	
	goto	l5121
	line	1301
	
l2860:	
	
l5113:	
	movf	(printf@c),w
	movwf	(??_printf+0)+0
	addwf	(??_printf+0)+0,w
	addlw	low((_dpowers-__stringbase))
	movwf	fsr0
	fcall	stringdir
	movwf	(??_printf+1)+0
	fcall	stringdir
	movwf	(??_printf+1)+0+1
	movf	1+(??_printf+1)+0,w
	subwf	(printf@_val+1),w
	skipz
	goto	u2815
	movf	0+(??_printf+1)+0,w
	subwf	(printf@_val),w
u2815:
	skipnc
	goto	u2811
	goto	u2810
u2811:
	goto	l5117
u2810:
	goto	l5121
	line	1302
	
l5115:	
	goto	l5121
	
l2862:	
	line	1300
	
l5117:	
	movlw	(01h)
	movwf	(??_printf+0)+0
	movf	(??_printf+0)+0,w
	addwf	(printf@c),f
	
l5119:	
	movf	(printf@c),w
	xorlw	05h
	skipz
	goto	u2821
	goto	u2820
u2821:
	goto	l5113
u2820:
	goto	l5121
	
l2861:	
	line	1433
	
l5121:	
	movf	(printf@flag),w
	andlw	03h
	btfsc	status,2
	goto	u2831
	goto	u2830
u2831:
	goto	l5125
u2830:
	line	1434
	
l5123:	
	movlw	(02Dh)
	fcall	_putch
	goto	l5125
	
l2863:	
	line	1467
	
l5125:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(printf@c),w
	movwf	(??_printf+0)+0
	movf	(??_printf+0)+0,w
	movwf	(printf@prec)
	line	1469
	goto	l5131
	
l2865:	
	line	1484
	
l5127:	
	movlw	low(0Ah)
	movwf	(?___lwmod)
	movlw	high(0Ah)
	movwf	((?___lwmod))+1
	movf	(printf@prec),w
	movwf	(??_printf+0)+0
	addwf	(??_printf+0)+0,w
	addlw	low((_dpowers-__stringbase))
	movwf	fsr0
	fcall	stringdir
	movwf	(?___lwdiv)
	fcall	stringdir
	movwf	(?___lwdiv+1)
	movf	(printf@_val+1),w
	clrf	1+(?___lwdiv)+02h
	addwf	1+(?___lwdiv)+02h
	movf	(printf@_val),w
	clrf	0+(?___lwdiv)+02h
	addwf	0+(?___lwdiv)+02h

	fcall	___lwdiv
	movf	(1+(?___lwdiv)),w
	clrf	1+(?___lwmod)+02h
	addwf	1+(?___lwmod)+02h
	movf	(0+(?___lwdiv)),w
	clrf	0+(?___lwmod)+02h
	addwf	0+(?___lwmod)+02h

	fcall	___lwmod
	movf	(0+(?___lwmod)),w
	addlw	030h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_printf+1)+0
	movf	(??_printf+1)+0,w
	movwf	(printf@c)
	line	1516
	
l5129:	
	movf	(printf@c),w
	fcall	_putch
	goto	l5131
	line	1517
	
l2864:	
	line	1469
	
l5131:	
	movlw	(-1)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(??_printf+0)+0
	movf	(??_printf+0)+0,w
	addwf	(printf@prec),f
	movf	((printf@prec)),w
	xorlw	-1
	skipz
	goto	u2841
	goto	u2840
u2841:
	goto	l5127
u2840:
	goto	l5133
	
l2866:	
	goto	l5133
	line	1525
	
l2849:	
	line	540
	
l5133:	
	movlw	01h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(printf@f),f
	movlw	-01h
	addwf	(printf@f),w
	movwf	fsr0
	fcall	stringdir
	movwf	(??_printf+0)+0
	movf	(??_printf+0)+0,w
	movwf	(printf@c)
	movf	((printf@c)),f
	skipz
	goto	u2851
	goto	u2850
u2851:
	goto	l5089
u2850:
	goto	l2868
	
l2867:	
	goto	l2868
	line	1527
	
l2854:	
	line	1533
;	Return value of _printf is never used
	
l2868:	
	return
	opt stack 0
GLOBAL	__end_of_printf
	__end_of_printf:
;; =============== function _printf ends ============

	signat	_printf,602
	global	___awmod
psect	text235,local,class=CODE,delta=2
global __ptext235
__ptext235:

;; *************** function ___awmod *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\awmod.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    0[COMMON] int 
;;  dividend        2    2[COMMON] int 
;; Auto vars:     Size  Location     Type
;;  sign            1    6[COMMON] unsigned char 
;;  counter         1    5[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    0[COMMON] int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         4       0       0       0       0
;;      Locals:         2       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         7       0       0       0       0
;;Total ram usage:        7 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_phase
;; This function uses a non-reentrant model
;;
psect	text235
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\awmod.c"
	line	5
	global	__size_of___awmod
	__size_of___awmod	equ	__end_of___awmod-___awmod
	
___awmod:	
	opt	stack 5
; Regs used in ___awmod: [wreg+status,2+status,0]
	line	8
	
l5053:	
	clrf	(___awmod@sign)
	line	9
	btfss	(___awmod@dividend+1),7
	goto	u2691
	goto	u2690
u2691:
	goto	l5057
u2690:
	line	10
	
l5055:	
	comf	(___awmod@dividend),f
	comf	(___awmod@dividend+1),f
	incf	(___awmod@dividend),f
	skipnz
	incf	(___awmod@dividend+1),f
	line	11
	clrf	(___awmod@sign)
	bsf	status,0
	rlf	(___awmod@sign),f
	goto	l5057
	line	12
	
l3759:	
	line	13
	
l5057:	
	btfss	(___awmod@divisor+1),7
	goto	u2701
	goto	u2700
u2701:
	goto	l5061
u2700:
	line	14
	
l5059:	
	comf	(___awmod@divisor),f
	comf	(___awmod@divisor+1),f
	incf	(___awmod@divisor),f
	skipnz
	incf	(___awmod@divisor+1),f
	goto	l5061
	
l3760:	
	line	15
	
l5061:	
	movf	(___awmod@divisor+1),w
	iorwf	(___awmod@divisor),w
	skipnz
	goto	u2711
	goto	u2710
u2711:
	goto	l5079
u2710:
	line	16
	
l5063:	
	clrf	(___awmod@counter)
	bsf	status,0
	rlf	(___awmod@counter),f
	line	17
	goto	l5069
	
l3763:	
	line	18
	
l5065:	
	movlw	01h
	
u2725:
	clrc
	rlf	(___awmod@divisor),f
	rlf	(___awmod@divisor+1),f
	addlw	-1
	skipz
	goto	u2725
	line	19
	
l5067:	
	movlw	(01h)
	movwf	(??___awmod+0)+0
	movf	(??___awmod+0)+0,w
	addwf	(___awmod@counter),f
	goto	l5069
	line	20
	
l3762:	
	line	17
	
l5069:	
	btfss	(___awmod@divisor+1),(15)&7
	goto	u2731
	goto	u2730
u2731:
	goto	l5065
u2730:
	goto	l5071
	
l3764:	
	goto	l5071
	line	21
	
l3765:	
	line	22
	
l5071:	
	movf	(___awmod@divisor+1),w
	subwf	(___awmod@dividend+1),w
	skipz
	goto	u2745
	movf	(___awmod@divisor),w
	subwf	(___awmod@dividend),w
u2745:
	skipc
	goto	u2741
	goto	u2740
u2741:
	goto	l5075
u2740:
	line	23
	
l5073:	
	movf	(___awmod@divisor),w
	subwf	(___awmod@dividend),f
	movf	(___awmod@divisor+1),w
	skipc
	decf	(___awmod@dividend+1),f
	subwf	(___awmod@dividend+1),f
	goto	l5075
	
l3766:	
	line	24
	
l5075:	
	movlw	01h
	
u2755:
	clrc
	rrf	(___awmod@divisor+1),f
	rrf	(___awmod@divisor),f
	addlw	-1
	skipz
	goto	u2755
	line	25
	
l5077:	
	movlw	low(01h)
	subwf	(___awmod@counter),f
	btfss	status,2
	goto	u2761
	goto	u2760
u2761:
	goto	l5071
u2760:
	goto	l5079
	
l3767:	
	goto	l5079
	line	26
	
l3761:	
	line	27
	
l5079:	
	movf	(___awmod@sign),w
	skipz
	goto	u2770
	goto	l5083
u2770:
	line	28
	
l5081:	
	comf	(___awmod@dividend),f
	comf	(___awmod@dividend+1),f
	incf	(___awmod@dividend),f
	skipnz
	incf	(___awmod@dividend+1),f
	goto	l5083
	
l3768:	
	line	29
	
l5083:	
	movf	(___awmod@dividend+1),w
	clrf	(?___awmod+1)
	addwf	(?___awmod+1)
	movf	(___awmod@dividend),w
	clrf	(?___awmod)
	addwf	(?___awmod)

	goto	l3769
	
l5085:	
	line	30
	
l3769:	
	return
	opt stack 0
GLOBAL	__end_of___awmod
	__end_of___awmod:
;; =============== function ___awmod ends ============

	signat	___awmod,8314
	global	___lwmod
psect	text236,local,class=CODE,delta=2
global __ptext236
__ptext236:

;; *************** function ___lwmod *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\lwmod.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    8[COMMON] unsigned int 
;;  dividend        2   10[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;  counter         1   13[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    8[COMMON] unsigned int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         4       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         6       0       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_printf
;; This function uses a non-reentrant model
;;
psect	text236
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\lwmod.c"
	line	5
	global	__size_of___lwmod
	__size_of___lwmod	equ	__end_of___lwmod-___lwmod
	
___lwmod:	
	opt	stack 6
; Regs used in ___lwmod: [wreg+status,2+status,0]
	line	8
	
l5031:	
	movf	(___lwmod@divisor+1),w
	iorwf	(___lwmod@divisor),w
	skipnz
	goto	u2631
	goto	u2630
u2631:
	goto	l5049
u2630:
	line	9
	
l5033:	
	clrf	(___lwmod@counter)
	bsf	status,0
	rlf	(___lwmod@counter),f
	line	10
	goto	l5039
	
l3569:	
	line	11
	
l5035:	
	movlw	01h
	
u2645:
	clrc
	rlf	(___lwmod@divisor),f
	rlf	(___lwmod@divisor+1),f
	addlw	-1
	skipz
	goto	u2645
	line	12
	
l5037:	
	movlw	(01h)
	movwf	(??___lwmod+0)+0
	movf	(??___lwmod+0)+0,w
	addwf	(___lwmod@counter),f
	goto	l5039
	line	13
	
l3568:	
	line	10
	
l5039:	
	btfss	(___lwmod@divisor+1),(15)&7
	goto	u2651
	goto	u2650
u2651:
	goto	l5035
u2650:
	goto	l5041
	
l3570:	
	goto	l5041
	line	14
	
l3571:	
	line	15
	
l5041:	
	movf	(___lwmod@divisor+1),w
	subwf	(___lwmod@dividend+1),w
	skipz
	goto	u2665
	movf	(___lwmod@divisor),w
	subwf	(___lwmod@dividend),w
u2665:
	skipc
	goto	u2661
	goto	u2660
u2661:
	goto	l5045
u2660:
	line	16
	
l5043:	
	movf	(___lwmod@divisor),w
	subwf	(___lwmod@dividend),f
	movf	(___lwmod@divisor+1),w
	skipc
	decf	(___lwmod@dividend+1),f
	subwf	(___lwmod@dividend+1),f
	goto	l5045
	
l3572:	
	line	17
	
l5045:	
	movlw	01h
	
u2675:
	clrc
	rrf	(___lwmod@divisor+1),f
	rrf	(___lwmod@divisor),f
	addlw	-1
	skipz
	goto	u2675
	line	18
	
l5047:	
	movlw	low(01h)
	subwf	(___lwmod@counter),f
	btfss	status,2
	goto	u2681
	goto	u2680
u2681:
	goto	l5041
u2680:
	goto	l5049
	
l3573:	
	goto	l5049
	line	19
	
l3567:	
	line	20
	
l5049:	
	movf	(___lwmod@dividend+1),w
	clrf	(?___lwmod+1)
	addwf	(?___lwmod+1)
	movf	(___lwmod@dividend),w
	clrf	(?___lwmod)
	addwf	(?___lwmod)

	goto	l3574
	
l5051:	
	line	21
	
l3574:	
	return
	opt stack 0
GLOBAL	__end_of___lwmod
	__end_of___lwmod:
;; =============== function ___lwmod ends ============

	signat	___lwmod,8314
	global	___lwdiv
psect	text237,local,class=CODE,delta=2
global __ptext237
__ptext237:

;; *************** function ___lwdiv *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\lwdiv.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    0[COMMON] unsigned int 
;;  dividend        2    2[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;  quotient        2    5[COMMON] unsigned int 
;;  counter         1    7[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    0[COMMON] unsigned int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         4       0       0       0       0
;;      Locals:         3       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         8       0       0       0       0
;;Total ram usage:        8 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_printf
;; This function uses a non-reentrant model
;;
psect	text237
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\lwdiv.c"
	line	5
	global	__size_of___lwdiv
	__size_of___lwdiv	equ	__end_of___lwdiv-___lwdiv
	
___lwdiv:	
	opt	stack 6
; Regs used in ___lwdiv: [wreg+status,2+status,0]
	line	9
	
l5005:	
	clrf	(___lwdiv@quotient)
	clrf	(___lwdiv@quotient+1)
	line	10
	
l5007:	
	movf	(___lwdiv@divisor+1),w
	iorwf	(___lwdiv@divisor),w
	skipnz
	goto	u2561
	goto	u2560
u2561:
	goto	l5027
u2560:
	line	11
	
l5009:	
	clrf	(___lwdiv@counter)
	bsf	status,0
	rlf	(___lwdiv@counter),f
	line	12
	goto	l5015
	
l3559:	
	line	13
	
l5011:	
	movlw	01h
	
u2575:
	clrc
	rlf	(___lwdiv@divisor),f
	rlf	(___lwdiv@divisor+1),f
	addlw	-1
	skipz
	goto	u2575
	line	14
	
l5013:	
	movlw	(01h)
	movwf	(??___lwdiv+0)+0
	movf	(??___lwdiv+0)+0,w
	addwf	(___lwdiv@counter),f
	goto	l5015
	line	15
	
l3558:	
	line	12
	
l5015:	
	btfss	(___lwdiv@divisor+1),(15)&7
	goto	u2581
	goto	u2580
u2581:
	goto	l5011
u2580:
	goto	l5017
	
l3560:	
	goto	l5017
	line	16
	
l3561:	
	line	17
	
l5017:	
	movlw	01h
	
u2595:
	clrc
	rlf	(___lwdiv@quotient),f
	rlf	(___lwdiv@quotient+1),f
	addlw	-1
	skipz
	goto	u2595
	line	18
	movf	(___lwdiv@divisor+1),w
	subwf	(___lwdiv@dividend+1),w
	skipz
	goto	u2605
	movf	(___lwdiv@divisor),w
	subwf	(___lwdiv@dividend),w
u2605:
	skipc
	goto	u2601
	goto	u2600
u2601:
	goto	l5023
u2600:
	line	19
	
l5019:	
	movf	(___lwdiv@divisor),w
	subwf	(___lwdiv@dividend),f
	movf	(___lwdiv@divisor+1),w
	skipc
	decf	(___lwdiv@dividend+1),f
	subwf	(___lwdiv@dividend+1),f
	line	20
	
l5021:	
	bsf	(___lwdiv@quotient)+(0/8),(0)&7
	goto	l5023
	line	21
	
l3562:	
	line	22
	
l5023:	
	movlw	01h
	
u2615:
	clrc
	rrf	(___lwdiv@divisor+1),f
	rrf	(___lwdiv@divisor),f
	addlw	-1
	skipz
	goto	u2615
	line	23
	
l5025:	
	movlw	low(01h)
	subwf	(___lwdiv@counter),f
	btfss	status,2
	goto	u2621
	goto	u2620
u2621:
	goto	l5017
u2620:
	goto	l5027
	
l3563:	
	goto	l5027
	line	24
	
l3557:	
	line	25
	
l5027:	
	movf	(___lwdiv@quotient+1),w
	clrf	(?___lwdiv+1)
	addwf	(?___lwdiv+1)
	movf	(___lwdiv@quotient),w
	clrf	(?___lwdiv)
	addwf	(?___lwdiv)

	goto	l3564
	
l5029:	
	line	26
	
l3564:	
	return
	opt stack 0
GLOBAL	__end_of___lwdiv
	__end_of___lwdiv:
;; =============== function ___lwdiv ends ============

	signat	___lwdiv,8314
	global	_init_usart
psect	text238,local,class=CODE,delta=2
global __ptext238
__ptext238:

;; *************** function _init_usart *****************
;; Defined at:
;;		line 8 in file "C:\git\Mercury2014-code\mercury2014_PIC_code\usart.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text238
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\usart.c"
	line	8
	global	__size_of_init_usart
	__size_of_init_usart	equ	__end_of_init_usart-_init_usart
	
_init_usart:	
	opt	stack 7
; Regs used in _init_usart: [wreg]
	line	9
	
l4995:	
;usart.c: 9: TRISC6 = 1;
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	bsf	(1086/8)^080h,(1086)&7
	line	10
;usart.c: 10: TRISC7 = 1;
	bsf	(1087/8)^080h,(1087)&7
	line	11
	
l4997:	
;usart.c: 11: SPBRG = 3;
	movlw	(03h)
	movwf	(153)^080h	;volatile
	line	12
;usart.c: 12: TXSTA = 0b00100000;
	movlw	(020h)
	movwf	(152)^080h	;volatile
	line	13
;usart.c: 13: RCSTA = 0b10010000;
	movlw	(090h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(24)	;volatile
	line	14
	
l2120:	
	return
	opt stack 0
GLOBAL	__end_of_init_usart
	__end_of_init_usart:
;; =============== function _init_usart ends ============

	signat	_init_usart,88
	global	_putch
psect	text239,local,class=CODE,delta=2
global __ptext239
__ptext239:

;; *************** function _putch *****************
;; Defined at:
;;		line 24 in file "C:\git\Mercury2014-code\mercury2014_PIC_code\usart.c"
;; Parameters:    Size  Location     Type
;;  input           1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  input           1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_printf
;;		_LCD_init
;;		_getche
;; This function uses a non-reentrant model
;;
psect	text239
	file	"C:\git\Mercury2014-code\mercury2014_PIC_code\usart.c"
	line	24
	global	__size_of_putch
	__size_of_putch	equ	__end_of_putch-_putch
	
_putch:	
	opt	stack 6
; Regs used in _putch: [wreg]
;putch@input stored from wreg
	movwf	(putch@input)
	line	25
	
l4991:	
;usart.c: 25: while(!TXIF)
	goto	l2123
	
l2124:	
	line	28
;usart.c: 26: {
;usart.c: 27: continue;
	
l2123:	
	line	25
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(100/8),(100)&7
	goto	u2551
	goto	u2550
u2551:
	goto	l2123
u2550:
	goto	l4993
	
l2125:	
	line	29
	
l4993:	
;usart.c: 28: }
;usart.c: 29: TXREG = input;
	movf	(putch@input),w
	movwf	(25)	;volatile
	line	30
	
l2126:	
	return
	opt stack 0
GLOBAL	__end_of_putch
	__end_of_putch:
;; =============== function _putch ends ============

	signat	_putch,4216
psect	text240,local,class=CODE,delta=2
global __ptext240
__ptext240:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
