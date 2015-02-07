#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

int leadA = %0000;
int leadB = %0000;
int leadC = %0000;
int bitmask;
int phase1;
int phase2;
int phase2;


void init_motors(void)
{
	TRISC = (TRISC | bitmask ) ^ bitmask ;
	bitmask = leadA | leadB | leadC;
	phase1 = leadA | leadB;
	phase2 = leadB | leadC;
	phase3 = leadC | leadA;
}


void motor_controller_test(void)
{
	init_motors();
	int p=0;
	while( 1 ){
		phase(p++);
		__delay_ms(1000);
	}
}

void phase( int p )
{
	p = p % 3
	if ( p==0 ){
		PORTC = (PORTC | bitmask) ^ phase1;
	} else if ( p==1 ){
		PORTC = (PORTC | bitmask) ^ phase2;
	} else if ( p==2 ) {
		PORTC = (PORTC | bitmask) ^ phase3;
	}
}


