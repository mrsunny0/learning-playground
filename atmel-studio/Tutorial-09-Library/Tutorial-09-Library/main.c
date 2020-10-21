#define F_CPU 16000000UL

// libraries
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "UART.h"

// main
int main(void)
{
	initUART();
	sei();
	
	while (1)
	{
		_delay_ms(1000);
	}
}

// interrupt receive byte
ISR(USART_RX_vect) {
	sendChar(UDR0);
	sendChar('\n');
}

