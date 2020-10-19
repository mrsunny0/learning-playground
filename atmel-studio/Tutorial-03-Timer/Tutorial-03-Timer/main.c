#define F_CPU 16000000UL

#include <avr/io.h>

#define LEDPIN PORTD7

// delay
/**
 * period of a clock is 1/F_CPU = 1/16M = 0.0625 micro seconds
 * if we want 1 second, we need to find how many periods that is
 * 1 second / 0.0625 micro seconds / period = 16M period counts per second
 * however, the clock can only hold 65535 values
 * this means, to contain 16M periods within one second and fit that into 2^16 - 1 bit resolution, prescale by 244.144 ...
 * alternatively, estimate by prescaling by 256 or 2^8.
 * TCCR1B, change CS10, CS11, and CS12 prescale bits
 * CS12, CS11, CS10 = 101 = 1024 divider
 * 16M / 1024 prescaler = 15625, this is the number you want to monitor, make sure its a hole number or there is drift
*/ 

void setup() {
	DDRD |= (1<<LEDPIN);
	TCCR1B |= (1<<CS10) | (1<<CS12); //-> divider by 1024
}

int main(void)
{
	setup(); 
	
    while (1) 
    {
		if(TCNT1 > 15625)
		{
			PORTD ^= (1<<LEDPIN);
			TCNT1 = 0; // reset and count again
		}
    }
}

