#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <avr/io.h>

volatile int counter = 0;
uint8_t brightness = 0;

/************************************************************************/
/* enable interrupt for Int0 */
/************************************************************************/
void enableInterrupt() {
	EICRA |= (1<<ISC01); // condition on interrupt firing
	EIMSK |= (1<<INT0); // turn on interrupts
	sei();
}

void enablePWM() {
	TCCR0A |= (1<<WGM00) | (1<<WGM01); // enable timer0, in fast PWM mode
	TCCR0A |= (1<<COM0A1); // counter in non-inverting mode, this sets the comparison, output compare
	TCCR0B |= (1<<CS00); // pre-scalers, none
}

/************************************************************************/
/* setup */
/************************************************************************/
void setup() {
	DDRD &= ~(1<<PORTD2); // input interrupt pin
	PORTD |= (1<<PORTD2); // enable pull-up resistor
	DDRD |= (1<<PORTD6); // output LED pin
}

/************************************************************************/
/* main */
/************************************************************************/
int main(void)
{
	setup();
	enablePWM();
	enableInterrupt();
    while (1) 
    {
		OCR0A = brightness;
    }
}

/************************************************************************/
/* interrupts */
/************************************************************************/
ISR(INT0_vect) {
	// de-bounce delay
	_delay_ms(180); 
	
	// check if pin is LOW
	if ( ~(PORTD & (1<<PORTD2)) ) {
		if (counter % 2) {
			brightness = 10;
		} else {
			brightness = 250;
		}
	}
	
	// increment counter
	counter++;
}

