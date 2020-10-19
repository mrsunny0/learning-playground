// defines
#define F_CPU 16000000UL

// includes
#include <avr/io.h>
#include <util/delay.h>

// MCU variables
#define LEDPIN PORTD6
#define delay 1000

/************************************************************************/
/* Setup                                                                */
/************************************************************************/
void setup() {
	DDRD = (1<<LEDPIN);
}

/************************************************************************/
/* Main                                                                 */
/************************************************************************/
int main(void)
{
	setup();
    while (1) 
    {
		PORTD ^= (1<<LEDPIN);
		_delay_ms(delay);
    }
}

