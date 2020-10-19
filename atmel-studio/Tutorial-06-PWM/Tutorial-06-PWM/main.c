#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>


uint8_t brightness = 0;

void setup() {
	DDRD |= (1<<PORTD6);
	TCCR0A |= (1<<WGM00) | (1<<WGM01); // timer0 and fast PWM mode
	TCCR0A |= (1<<COM0A1);
	TCCR0B |= (1<<CS00); // do not prescale the clock
}

int main(void)
{
	setup();
    while (1) 
    {
		//for (brightness=0; brightness<255; brightness++) {
			//OCR0A = brightness; // sets the max PWM width, during compares
			//_delay_ms(10);
		//}
		OCR0A = 10;
		//for (brightness=255; brightness>0; brightness--) {
			//OCR0A = brightness;
			//_delay_ms(10);
		//}
    }
}

