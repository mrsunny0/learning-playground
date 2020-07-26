#include "reg_map.h"
#include "usart.h"
#include "util.h"

void init_usart(unsigned long baud_rate) {
	__ENABLE_USART__;
	
	unsigned long lUBRR = div(CPU_CLK, (8UL * baud_rate)) - 0x01;
	unsigned char * cUBRR = (unsigned char *)&lUBRR;

	UBRR0H = *(cUBRR + 1);
	UBRR0L = *(cUBRR + 0);
	
	__CHAR_SIZE_8BIT__;
	__PARITY_DISABLED__;
	
	__STOP_1_BIT__;

	__RX_ENABLE__;
	__TX_ENABLE__;
	
	__RXCI_DISABLE__;
	__TXCI_DISABLE__;
	__UDRI_DISABLE__;
	
	__SET_TX_2X_SPEED__;
	
	__MODE_ASYNC__;
	
}

unsigned char sscanc(void) {
	return usart_read();
}

unsigned char sprintc(unsigned char data) {
	usart_write(data);
	return 0;
}

unsigned char sprints(unsigned char data[]) {
	unsigned int indx = 0;

	while(data[indx] != '\0') {
		usart_write(data[indx++]);
	}
	
	return 0;
}

unsigned char sprintnl(void) {
	usart_write('\n');
}

unsigned char sprintcr(void) {
	usart_write('\r');
}




