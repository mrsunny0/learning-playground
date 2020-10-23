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

uint16_t readADC(void) 
{
	// start conversion
	ADCSRA |= (1<<ADSC);
	
	// return the value stored in this register, 10-bit value by default, stored in 16-bit
	return ADC; 
}

// read specific channel
uint16_t readADCChannel(uint8_t channel) 
{
	// modulo to lower 3 bits, so between 0-7
	// use a bit mask to keep the original lower 3 bits
	channel = channel & 0b00000111; 
	
	// select ADMUX pin
	/**
	 * ADC0 - ADC7 go from binary 0000 to 0111
	 * ADCMUX is offset by 0xfc
	 */
	ADMUX = (ADMUX & 0xf8); // this clears the last 3 bits, which is the ADC0-7 pins
	ADMUX |= channel; // choose the pin from ADC0-7, which is 0000 to 0111
	
	// start conversion
	ADCSRA |= (1<<ADSC); 
	
	// wait until conversion is finished
	while(ADCSRA & (1<<ADSC)); // ADSC is cleared when conversion is finished
	
	// return register value
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
		data = readADCChannel(0);

		// convert data
		sprintf(buffer, "%d", data);
		sendString(buffer);
		sendChar('\n');
		
		// delay
		_delay_ms(1000);
    }
}

