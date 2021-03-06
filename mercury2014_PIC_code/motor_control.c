#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>


/*
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
*/

//int bitmaskR;
//int phase1R;
//int phase2R;
//int phase3R;

void init_motors(void)
{
	// Right motor
	//bitmaskR = leadAHighR | leadALowR | leadBHighR | leadBLowR | leadCHighR | leadCLowR;
	//TRISD = TRISD & 0b00000011;//(TRISD | bitmaskR ) ^ bitmaskR ;
	//bitmaskR = leadA | leadB | leadC;
	//phase1R = leadAHighR | leadBLowR;
	//phase2R = leadBHighR | leadCLowR;
	//phase3R = leadCHighR | leadALowR;

	// Left motor
	TRISD = TRISD & 0b11111100;
	TRISB = TRISB & 0b11001001;
}


/*
void fastloop(int p){
	while(p%3 != 2){
		p++;
		lphase(p);
		rphase(p);
	}
	while(1){
			__B_HIGH_L = __C_HIGH_L = __A_LOW_L = __C_LOW_L = 0;
			__A_HIGH_L = __B_LOW_L = 1;
				__B_HIGH_R = __C_HIGH_R = __A_LOW_R = __C_LOW_R = 0;
				__A_HIGH_R = __B_LOW_R = 1;

			__A_HIGH_L = __C_HIGH_L = __A_LOW_L = __B_LOW_L = 0;
			__B_HIGH_L = __C_LOW_L = 1;
				__A_HIGH_R = __C_HIGH_R = __A_LOW_R = __B_LOW_R = 0;
				__B_HIGH_R = __C_LOW_R = 1;

			__A_HIGH_L = __B_HIGH_L = __B_LOW_L = __C_LOW_L = 0;
			__C_HIGH_L = __A_LOW_L = 1;
				__A_HIGH_R = __B_HIGH_R = __B_LOW_R = __C_LOW_R = 0;
				__C_HIGH_R = __A_LOW_R = 1;
	}
}
void lphase(int p){
	p=p%3;
		if (p == 0)
		{
			__B_HIGH_L = __C_HIGH_L = __A_LOW_L = __C_LOW_L = 0;
			__A_HIGH_L = __B_LOW_L = 1;
		}
		else if (p == 1)
		{
			__A_HIGH_L = __C_HIGH_L = __A_LOW_L = __B_LOW_L = 0;
			__B_HIGH_L = __C_LOW_L = 1;
		}
		else if (p == 2)
		{
			__A_HIGH_L = __B_HIGH_L = __B_LOW_L = __C_LOW_L = 0;
			__C_HIGH_L = __A_LOW_L = 1;
		}
}
void rphase(int p){
	p=p%3;
		if (p == 0)
		{
			__B_HIGH_R = __C_HIGH_R = __A_LOW_R = __C_LOW_R = 0;
			__A_HIGH_R = __B_LOW_R = 1;
		}
		else if (p == 1)
		{
			__A_HIGH_R = __C_HIGH_R = __A_LOW_R = __B_LOW_R = 0;
			__B_HIGH_R = __C_LOW_R = 1;
		}
		else if (p == 2)
		{
			__A_HIGH_R = __B_HIGH_R = __B_LOW_R = __C_LOW_R = 0;
			__C_HIGH_R = __A_LOW_R = 1;
		}
}

*/
void phase( int p, char motor )
{
	p = p % 3;
	if (motor == __MOTOR_R) {
		if (p == 0)
		{
			__B_HIGH_R = __C_HIGH_R = __A_LOW_R = __C_LOW_R = 0;
			__A_HIGH_R = __B_LOW_R = 1;
		}
		else if (p == 1)
		{
			__A_HIGH_R = __C_HIGH_R = __A_LOW_R = __B_LOW_R = 0;
			__B_HIGH_R = __C_LOW_R = 1;
		}
		else if (p == 2)
		{
			__A_HIGH_R = __B_HIGH_R = __B_LOW_R = __C_LOW_R = 0;
			__C_HIGH_R = __A_LOW_R = 1;
		}
	}
	else if (motor == __MOTOR_L) {
		if (p == 0)
		{
			__B_HIGH_L = __C_HIGH_L = __A_LOW_L = __C_LOW_L = 0;
			__A_HIGH_L = __B_LOW_L = 1;
		}
		else if (p == 1)
		{
			__A_HIGH_L = __C_HIGH_L = __A_LOW_L = __B_LOW_L = 0;
			__B_HIGH_L = __C_LOW_L = 1;
		}
		else if (p == 2)
		{
			__A_HIGH_L = __B_HIGH_L = __B_LOW_L = __C_LOW_L = 0;
			__C_HIGH_L = __A_LOW_L = 1;
		}
	}
}


