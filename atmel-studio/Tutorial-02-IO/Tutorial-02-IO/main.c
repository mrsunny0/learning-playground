#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>

#define LEDPIN PORTD7
#define INPUTPIN PORTD6

void setup(void)
{
	DDRD |= (1<<LEDPIN);
	DDRD &= ~(1<<INPUTPIN);
	// PORTD |= (1<<INPUTPIN); // optional pull up resistor
}

int main(void)
{
    setup();
    while (1) 
    {
		if (PIND & (1<<INPUTPIN))
		{
			PORTD ^= (1<<LEDPIN);
			_delay_ms(100);
		} else {
			PORTD ^= (1<<LEDPIN);
			_delay_ms(500);
		}
    }
}

