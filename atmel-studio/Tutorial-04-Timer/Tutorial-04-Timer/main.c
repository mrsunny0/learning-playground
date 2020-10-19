#define F_CPU 16000000UL

#include <avr/io.h>

void T1delay(void);

void setup() {
	DDRD |= (1<<PORTD7);
}

int main(void)
{
	setup();
	
    while (1) 
    {
		PORTD ^= (1<<PORTD7);
		T1delay();
    }
}

void T1delay()
{
	TCCR1B |= (1<<CS10) | (1<<CS12); // pre-scale to 1024, look up datasheet for TCCR1B register
	
	// 15625 counts for 1 second, given 16 MHz and 65535 TCNT1 register holder
	// set prevalue, and wait for overflows
	TCNT1 = 65535 - 15625; // start count from 49910
	
	// require interrupt flag for overflow checking
	// TIFR1 has a TOV (overflow) bit
	while( (TIFR1 & (1<<TOV1)) == 0) {
		// wait
	}
	
	// reset timer
	TCNT1 = 0;
	
	// per the datasheet, this needs to be redefined, because it gets cleared during overflow, and needs to be manually changed
	TIFR1 = (1<<TOV1);
}
