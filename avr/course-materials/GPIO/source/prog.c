#include "reg_map.h"

void init_port(void);
unsigned char read_portb(void);


void init_port(void) {
	MCUCR &= ~0x10;
	
	DDRB &= ~0x03;
	PORTB &= ~0x03;
	
	DDRC &= ~0x03;
	PORTC &= ~0x03;
}

unsigned char read_portb(void) {
	unsigned char data;
	
	DDRB &= 0x03;
	PORTB |= 0x03;
	asm volatile("nop" : :);
	
	data = PINB;
	
	DDRB &= ~0x03;
	PORTB &= ~0x03;
	
	return data;
}

void main(void) {
	unsigned char portb_data;
	
	init_port();
	
	DDRC |= 0x03;
	
	while(1) {
		portb_data = read_portb();
		
		if((portb_data & 0x01) == 0x01)
			PORTC &= ~0x01;
		
		if((portb_data & 0x01) == 0x00)
			PORTC |= 0x01;
		
		if((portb_data & 0x02) == 0x02)
			PORTC &= ~0x02;
		
		if((portb_data & 0x02) == 0x00)
			PORTC |= 0x02;
	}
	
	DDRC &= ~0x03;
	PORTC &= ~0x03;
}