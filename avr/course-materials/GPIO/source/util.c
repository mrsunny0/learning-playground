#include "util.h"

unsigned long div(unsigned long dividend, unsigned long divisor) {
	unsigned long quotient = 0;
	
	while(dividend >= divisor) {
		dividend = dividend - divisor;
		quotient++;
	}

	return quotient;
}

int modulus(int dividend, int divisor) {
	while(dividend >= divisor) {
		dividend -= divisor;
	}
	
	return dividend;
}

void _int2asciihex(unsigned int num, unsigned char ascii_val[]) {
	unsigned char digit[4], indx;
	
	digit[0] = (num & 0xF000) >> 12;
	digit[1] = (num & 0xF00) >> 8;
	digit[2] = (num & 0xF0) >> 4;
	digit[3] = (num & 0xF);
	
	for(indx = 0; indx < 4; indx++) {
		if(digit[indx] >= 0 && digit[indx] <= 9)
			ascii_val[indx] = digit[indx] + '0';
		else if(digit[indx] >= 0xA && digit[indx] <= 0xF)
			ascii_val[indx] = digit[indx] + 'A' - 0xA;
	}
}

void _char2asciihex(unsigned char num, unsigned char ascii_val[]) {
	unsigned char digit[4], indx;
	
	digit[0] = (num & 0xF0) >> 4;
	digit[1] = (num & 0xF);
	
	for(indx = 0; indx < 2; indx++) {
		if(digit[indx] >= 0 && digit[indx] <= 9)
			ascii_val[indx] = digit[indx] + '0';
		else if(digit[indx] >= 0xA && digit[indx] <= 0xF)
			ascii_val[indx] = digit[indx] + 'A' - 0xA;
	}
}