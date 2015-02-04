#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>
#include "motor_controller"

__CONFIG(FOSC_XT & WDTE_OFF & PWRTE_OFF & BOREN_OFF &
   LVP_ON & WRT_OFF & DEBUG_ON & CPD_OFF & CP_OFF);

int main()
{
	//***********************************************
	// The following block is a simple test program
	// for the motor controller circuit. DO NOT keep
	// this test in the final program.
	
	//***********************************************
	motor_controller_test();
	return 0;
}
