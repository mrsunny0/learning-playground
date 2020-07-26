#ifndef __USART_H__
#define __USART_H__

#ifdef USART_INTR
#define __INTERRUPT_DRIVEN__
#else
#undef 	__INTERRUPT_DRIVEN__
#endif

#define __ENABLE_USART__		(PRR &= ~(1 << PRUSART0))

#define __RX_ENABLE__			(UCSR0B	|= (1 << RXEN0))
#define __RX_DISABLE__			(UCSR0B	&= ~(1 << RXEN0))

#define __IS_RX_ENABLE__		(UCSR0B	& (1 << RXEN0))

#define __TX_ENABLE__			(UCSR0B	|= (1 << TXEN0))
#define __TX_DISABLE__			(UCSR0B	&= ~(1 << TXEN0))

#define __IS_TX_ENABLE__		(UCSR0B	& (1 << TXEN0))

#define __IS_RX_DATA_PRESENT__	(UCSR0A & (1 << RXC0))
#define __IS_TX_READY__			(UCSR0A & (1 << UDRE0))

#define __SET_TX_2X_SPEED__		(UCSR0A |= (1 << U2X0))
#define __SET_TX_1X_SPEED__		(UCSR0A &= ~(1 << U2X0))

#define __MODE_ASYNC__			{								\
								(UCSR0C &= ~(1 << UMSEL01));	\
								(UCSR0C &= ~(1 << UMSEL00));	\
								}
#define __MODE_SYNC__			{								\
								(UCSR0C &= ~(1 << UMSEL01));	\
								(UCSR0C |= (1 << UMSEL00));		\
								}
								
#define __PARITY_DISABLED__		{								\
								(UCSR0C &= ~(1 << UPM01));		\
								(UCSR0C &= ~(1 << UPM00));		\
								}						
#define __PARITY_ODD__			{								\
								(UCSR0C |= (1 << UPM01));		\
								(UCSR0C |= (1 << UPM00));		\
								}			
#define __PARITY_EVEN__			{								\
								(UCSR0C |= (1 << UPM01));		\
								(UCSR0C &= ~(1 << UPM00));		\
								}

#define __STOP_1_BIT__			(UCSR0C &= ~(1 << USBS0))
#define __STOP_2_BIT__			(UCSR0C |= (1 << USBS0))

#define __CHAR_SIZE_5BIT__		{								\
								(UCSR0B &= ~(1 << UCSZ02));		\
								(UCSR0C &= ~(1 << UCSZ01));		\
								(UCSR0C &= ~(1 << UCSZ00));		\
								}
#define __CHAR_SIZE_6BIT__		{								\
								(UCSR0B &= ~(1 << UCSZ02));		\
								(UCSR0C &= ~(1 << UCSZ01));		\
								(UCSR0C |= (1 << UCSZ00));		\
								}
#define __CHAR_SIZE_7BIT__		{								\
								(UCSR0B &= ~(1 << UCSZ02));		\
								(UCSR0C |= (1 << UCSZ01));		\
								(UCSR0C &= ~(1 << UCSZ00));		\
								}
#define __CHAR_SIZE_8BIT__		{								\
								(UCSR0B &= ~(1 << UCSZ02));		\
								(UCSR0C |= (1 << UCSZ01));		\
								(UCSR0C |= (1 << UCSZ00));		\
								}
#define __CHAR_SIZE_9BIT__		{								\
								(UCSR0B |= (1 << UCSZ02));		\
								(UCSR0C |= (1 << UCSZ01));		\
								(UCSR0C |= (1 << UCSZ00));		\
								}
								
#define __TXCI_ENABLE__			(UCSR0B |= (1 << TXCIE0))
#define __TXCI_DISABLE__		(UCSR0B &= ~(1 << TXCIE0))
#define __RXCI_ENABLE__			(UCSR0B |= (1 << RXCIE0))
#define __RXCI_DISABLE__		(UCSR0B &= ~(1 << RXCIE0))
#define __UDRI_ENABLE__			(UCSR0B |= (1 << UDRIE0))
#define __UDRI_DISABLE__		(UCSR0B &= ~(1 << UDRIE0))

#define __IS_FRAME_ERROR__		(UCSR0A & (1 << FE0))
#define __IS_DATA_OVERRUN__		(UCSR0A & (1 << DOR0))
#define __IS_PARTIY_ERROR__		(UCSR0A & (1 << UPE0))

#define __BAUD_9600__		9600UL
#define __BAUD_14400__		14400UL
#define __BAUD_19200__		19200UL
#define __BAUD_38400__		38400UL
#define __BAUD_57600__		57600UL
#define __BAUD_115200__		115200UL
								
#define __RET_FRAME_ERROR__			0xFE
#define __RET_DATA_OVERRUN__		0xFD
#define __RET_PARITY_ERROR__		0XFC	

void init_usart(unsigned long baud_rate);
unsigned char sprintc(unsigned char data);
unsigned char sprints(unsigned char data[]);
unsigned char sscanc(void);				
unsigned char sprintnl(void);
unsigned char sprintcr(void);			

static inline unsigned char usart_read(void)  __attribute__((__always_inline__));;
static inline void usart_write(unsigned char data)  __attribute__((__always_inline__));;

unsigned char usart_read(void) {
	unsigned char data;
	while(!__IS_RX_DATA_PRESENT__);
	
	if(__IS_FRAME_ERROR__) {
		data = UDR0;
		return __RET_FRAME_ERROR__;
	}
	
	if(__IS_DATA_OVERRUN__) {
		data = UDR0;
		return __RET_FRAME_ERROR__;
	}
	
	if(__IS_PARTIY_ERROR__) {
		data = UDR0;
		return __RET_PARITY_ERROR__;
	}
	
	data = UDR0;
	return data;
}

void usart_write(unsigned char data) {
	while(!__IS_TX_READY__);
	UDR0 = data;
}

#endif /* __USART_H__ */
