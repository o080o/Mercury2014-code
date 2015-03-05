#ifndef _XTAL_FREQ
#define _XTAL_FREQ 4000000 //2457600
#endif

// Pin definitions (PIC 1 - Motor control)
#define __A_HIGH_R		RD7
#define __A_LOW_R		RD6
#define __B_HIGH_R		RD5
#define __B_LOW_R		RD4
#define __C_HIGH_R		RD3
#define __C_LOW_R		RD2

#define __A_HIGH_L		RD0
#define __A_LOW_L		RD1
#define __B_HIGH_L		RB1
#define __B_LOW_L		RB2
#define __C_HIGH_L		RB4
#define __C_LOW_L		RB5

#define __LCD			RC6

// General definitions
#define __MOTOR_R		0
#define __MOTOR_L		1

// Defined in main.c
void init(void);

// Defined in motor_control.c
void init_motors(void);
void motor_controller_test();
void phase(int p, char motor);

// Defined in usart.c
void init_usart(void);
void putch(unsigned char input);
unsigned char getch(void);
unsigned char getche(void);

// Defined in sensors.c
void init_sensors(void);
