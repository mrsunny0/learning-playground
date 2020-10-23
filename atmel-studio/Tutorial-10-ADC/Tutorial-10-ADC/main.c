#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include "UART.h"

void initADC()
{
	// ADMUX = 0x00; // AREF, internal VREF turned off
	ADMUX |= (1<<REFS0); // AVCC with external capacitor at AREF pin, connected to 5V or 3V
	
	// set pre-scalar
	// should be between 50-200kHz
	// divide by 128, so 16MHz -> 125Hz, right in the middle
	ADCSRA |= (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0); // ADC control status register	
	
	// enable the ADC
	ADCSRA |= (1<<ADEN); // automatically uses ADC0 pin
}

uint16_t readADC() 
{
	// start conversion
	ADCSRA |= (1<<ADSC);
	
	// return the value stored in this register, 10-bit value by default, stored in 16-bit
	return ADC; 
}

void setup() 
{
	
}

int main(void)
{
	initUART();
	initADC();
	uint16_t data;
	char buffer[10];
	
    while (1) 
    {
		// read data
		data = readADC();

		// convert data
		sprintf(buffer, "%d", data);
		sendString(buffer);
		sendChar('\n');
		
		// delay
		_delay_ms(1000);
    }
}

