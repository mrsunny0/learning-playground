#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

char receiveChar();
void sendChar(char d);
void sendString(char* d);

void setup() {
	UBRR0L = 103; // check 24.11, examples of baud rate settings, table does the math for you
	UCSR0B |= (1<<TXEN0); // set status of bit
	UCSR0B |= (1<<RXEN0); // receive enable bit
	UCSR0C |= (1<<UCSZ00) | (1<<UCSZ01); // 1 bit of data per transfer 24.12.3
	
	// enabling interrupt
	UCSR0B |= (1 << RXCIE0); // Enable the USART receive Complete interrupt (USART_RXC)
}

int main(void)
{
	setup();
	char value;
	sei();
	
    while (1) 
    {
		_delay_ms(1000);
		sendString("HELLO WORLD");
		sendChar('\n');
    }
}

void sendChar(char data) {
	while(!(UCSR0A & (1<<UDRE0)));
	UDR0 = data;
}

void sendString(char* data) {
	while(*data) {
		sendChar(*data); // access content of pointer
		data++; // access next character in memory
	}
}

char receiveChar() {
	while(!(UCSR0A & (1<<RXC0))); // ready to accept a bit
	return UDR0; // note, it's the same bit that can be sent
}

// interrupt receive byte
ISR(USART_RX_vect) {
	sendChar(UDR0);
}

