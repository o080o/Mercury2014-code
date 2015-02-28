#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

void init_sensors(void)
{

}
void sensor_test(void)
{
	while(1){
		printf( "%d", get_val(0) );
	}
}
char get_value(char sensor)
{
	// see datasheet for bit interpretation
	ADCON0 = (0b01 << 7) | (sensor<<3) | (0b001);  
	ADCON1 = (0b1 << 7) | (0b0 << 6) | (0b0000);
	__delay_ms(100); // charge the internal capacitor
	ADCON0 = ADCON0 | 0b100;
	__delay_ms(100); // wait while the ADC converts the value
	int val = ADRESL;
	return val;
}


// sensor 0-7, selecting which channel is used
char get_dist(char sensor)
{
	int val = get_value(sensor);
	return val * 1;
}

