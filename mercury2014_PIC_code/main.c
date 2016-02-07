#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

__CONFIG(FOSC_HS & WDTE_OFF & PWRTE_OFF & BOREN_OFF &
   LVP_ON & WRT_OFF & DEBUG_ON & CPD_OFF & CP_OFF);

void init(){
	// Turn on power LED
	TRISB &= 0b11111110;
	LED = 1;

	init_usart();
	init_motors();
	init_servos();
}

void delayLoop(unsigned int n){
	for(int j=n;j>0;j--){
		NOP();
	}
}

int main()
{
	init();

	TRISD = 0b00000000;
	int i = 0;
	for (i = 0; i < 10; i++){
		LED = 0;
		__delay_ms(100);
		LED = 1;
		__delay_ms(100);
	}
	printf("Hello!");

	unsigned int p = 0;
	unsigned int n = 255;

	//setServo(__SERVO, 30);


	//for (i = 0; i < 2; i++){
	while(1){
		if (n>0){n--;}
		//if (n==0){n=255;fastloop(p);}

		if (p>=100){p=0;} // can't rely on overflow to reset p=0, because overflow happens on a number NOT divisible by 3. ex 256%3=1 while 0%3=0. this results in a skipped phase. instead we force a reset at an even multiple of 3.

		p++;
		p = 2;
		phase(p, __MOTOR_L);
		phase(p, __MOTOR_R);
		__delay_ms(100);
		//setServo( __SERVO, p/10 + 10 );
		//delayLoop( n );
	}
	//motor_controller_test();

	return 0;
}
