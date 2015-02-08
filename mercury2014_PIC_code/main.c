#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

__CONFIG(FOSC_XT & WDTE_OFF & PWRTE_OFF & BOREN_OFF &
   LVP_ON & WRT_OFF & DEBUG_ON & CPD_OFF & CP_OFF);

int main()
{
	// Turn on power LED
	TRISB &= 0b11111110;
	RB0 = 1;

	TRISD = 0b00000000;
	while(1)
	{
		//PORTD = 0b00100100;
		//__delay_ms(1000);
		//PORTD = 0b01001000;
		//__delay_ms(1000);
		PORTD = 0b10010000;
		__delay_ms(1000);
	}
	
/*	
	init_motors();

	//***********************************************
	// The following function is a simple test program
	// for the motor controller circuit. DO NOT keep
	// this test in the final program.
	//***********************************************
	motor_controller_test();
*/	return 0;
}
