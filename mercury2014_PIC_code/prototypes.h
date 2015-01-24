#ifndef _XTAL_FREQ
#define _XTAL_FREQ 2457600
#endif

// Defined in main.c
void init(void);

// Defined in motor_control.c
void init_motors(void);

// Defined in usart.c
void init_usart(void);
void putch(unsigned char input);
unsigned char getch(void);
unsigned char getche(void);

// Defined in sensors.c
void init_sensors(void);
