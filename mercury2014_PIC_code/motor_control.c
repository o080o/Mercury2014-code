#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

int leadAHigh = 0b00000100;
int leadALow  = 0b00001000;
int leadBHigh = 0b00010000;
int leadBLow  = 0b00100000;
int leadCHigh = 0b01000000;
int leadCLow  = 0b10000000;

int bitmask;
int phase1;
int phase2;
int phase3;


void init_motors(void)
{
	bitmask = leadAHigh | leadALow | leadBHigh | leadBLow | leadCHigh | leadCLow;
	TRISD = 0b00000000;//(TRISD | bitmask ) ^ bitmask ;
	//bitmask = leadA | leadB | leadC;
	phase1 = leadAHigh | leadBLow;
	phase2 = leadBHigh | leadCLow;
	phase3 = leadCHigh | leadALow;
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

void phase( int p )
{
	p = p % 3;
	if ( p==0 ){
		PORTD = ( (PORTD | bitmask) ^ bitmask ) | phase1;
	} else if ( p==1 ){
		PORTD = ( (PORTD | bitmask) ^ bitmask ) | phase2;
	} else if ( p==2 ) {
		PORTD = ( (PORTD | bitmask) ^ bitmask ) | phase3;
	}
}


