#include <htc.h>
#include "prototypes.h"
#include <stdio.h>
#include <stdlib.h>

// Set up USART with a baud rate of 9600.
void init_usart()
{
   TRISC6 = 1;
   TRISC7 = 1;
   SPBRG  = 51; // Baud Rate = Fosc / (16 (SPBRG+1) ) 
   // SPBRG + 1 = Fosc / (16 * BaudRate )
   // @8Mhz 9600Baud = (8000000 / 16*9600)-1 = 51
   TXSTA  = 0b00100100;
   RCSTA  = 0b10010000;
}

// ***************************************************************************
// The methods putch(), getch(), and getche() will be automatically used by
// the compiler and other native C methods. It is therefore necessary to
// declare them here in order for the USART module to function.
// ***************************************************************************

// Send one byte via USART.
void putch(unsigned char input)
{
   while(!TXIF)
   {
      continue;
   }
   TXREG = input;
}

// Receive one byte via USART.
unsigned char getch(void)
{
   while(!RCIF)
   {
      continue;
   }
   return RCREG;
}

// Receive one byte via USART and immediately send it back via USART.
unsigned char getche(void)
{
   unsigned char c;
   putch(c = getch());
   return c;
}
