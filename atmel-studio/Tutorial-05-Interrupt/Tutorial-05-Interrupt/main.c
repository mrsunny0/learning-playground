#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>

void setup() {
	sei(); // turn on global interrupt
	DDRD |= (1<<PORTD7);
	TCCR1B |= (1<<CS10) | (1<<CS12); // 1024 pre-scale value = 15625 cycles per 1 second
	TCCR1B |= (1<<WGM12); // wave form generation mode, CTC mode, clear timer on compare (alternatively from PWM)
	// check wave form generation mode bit description
	// then go under timer counter mode operation
	
	// use which control registers are valid
	// this will configure timer1 for a flag
	TIMSK1 |= (1<<OCIE1A);
	OCR1A = 15625; // constantly comparing against TCNT1. This is the number value that will be compared
}

int main(void)
{
	setup();
	
    while (1) 
    {
    }
}

// special block of interrupt vector routine
ISR(TIMER1_COMPA_vect) 
{
	PORTD ^= (1<<PORTD7);
}

