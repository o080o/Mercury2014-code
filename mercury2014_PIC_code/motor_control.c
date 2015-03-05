#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

int leadAHighR = 0b00000100;
int leadALowR  = 0b00001000;
int leadBHighR = 0b00010000;
int leadBLowR  = 0b00100000;
int leadCHighR = 0b01000000;
int leadCLowR  = 0b10000000;
int leadAHighL = 0b000001;
int leadALowL  = 0b000010;
int leadBHighL = 0b000100;
int leadBLowL  = 0b001000;
int leadCHighL = 0b010000;
int leadCLowL  = 0b100000;

int bitmaskR;
int phase1R;
int phase2R;
int phase3R;
int bitmaskL;
int phase1L;
int phase2L;
int phase3L;

void init_motors(void)
{
	bitmaskR = leadAHighR | leadALowR | leadBHighR | leadBLowR | leadCHighR | leadCLowR;
	bitmaskL = leadAHighL | leadALowL | leadBHighL | leadBLowL | leadCHighL | leadCLowL;

	TRISD = 0b00000000;//(TRISD | bitmaskR ) ^ bitmaskR ;
	//bitmaskR = leadA | leadB | leadC;
	phase1R = leadAHighR | leadBLowR;
	phase2R = leadBHighR | leadCLowR;
	phase3R = leadCHighR | leadALowR;

	TRISA = ( TRISA | bitmaskL ) ^ bitmaskL;
	phase1L = leadAHighL | leadBLowL;
	phase2L = leadBHighL | leadCLowL;
	phase3L = leadCHighL | leadALowL;
}


void motor_controller_test(void)
{
	while(1)
	{
		PORTD = 0b00100100;
		__delay_ms(1000);
		PORTD = 0b01001000;
		__delay_ms(1000);
		PORTD = 0b10010000;
		__delay_ms(1000);
	}
/*	int p=0;
	while( 1 ){
		phase(p++);
		__delay_ms(1000);
	}
*/
}

void phase( int p, char motor )
{
	p = p % 3;
	if (motor == 0) {
		if ( p==0 ){
			PORTD = ( (PORTD | bitmaskR) ^ bitmaskR ) | phase1R;
		} else if ( p==1 ){
			PORTD = ( (PORTD | bitmaskR) ^ bitmaskR ) | phase2R;
		} else if ( p==2 ) {
			PORTD = ( (PORTD | bitmaskR) ^ bitmaskR ) | phase3R;
		}
	}
	else if (motor == 1) {
		
	}
}


