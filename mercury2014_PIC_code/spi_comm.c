#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

void init_spi()
{
	TRISC |= 0b00010000;
	TRISC &= 0b11011111;
}

void spi_putch(unsigned char input)
{

}

unsigned char spi_getch()
{

}