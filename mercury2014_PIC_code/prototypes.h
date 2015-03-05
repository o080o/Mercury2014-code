#ifndef _XTAL_FREQ
#define _XTAL_FREQ 2457600
#endif

// Pin definitions (PIC 1 - Motor control)
#define __A_HIGH_1		RD2
#define __A_LOW_1		RD3
#define __B_HIGH_1		RD4
#define __B_LOW_1		RD5
#define __C_HIGH_1		RD6
#define __C_LOW_1		RD7

#define __A_HIGH_2		RA0
#define __A_LOW_2		RA1
#define __B_HIGH_2		RA2
#define __B_LOW_2		RA3
#define __C_HIGH_2		RA4
#define __C_LOW_2		RA5

// Defined in main.c
void init(void);

// Defined in motor_control.c
void init_motors(void);
void motor_controller_test();
void phase(int p);

// Defined in usart.c
void init_usart(void);
void putch(unsigned char input);
unsigned char getch(void);
unsigned char getche(void);

// Defined in sensors.c
void init_sensors(void);
