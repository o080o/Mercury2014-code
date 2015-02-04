#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

int bitmap = % 00001;
void init_motors(void)
{
}

void motor_controller_test(void)
{
	int p=0;
	while( 1 ){
		phase(p++);
	}
}

void phase( int p )
{
	p = p % 3
	if ( p==0 ){
		turn_A_High()
			turn_B_High()
	} else if ( p==1 ){
		...
	} else if ( p==2 ) {
		....
	}
}


