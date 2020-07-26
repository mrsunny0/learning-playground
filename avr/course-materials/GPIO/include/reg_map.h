#ifndef __ref_map_h__
#define __ref_map_h__

/* MCU control register */
#define MCUCR	(*(volatile unsigned char *) 0x55)

/* Stack pointer */
#define SPH		(*(volatile unsigned char *) 0x5E)
#define SPL		(*(volatile unsigned char *) 0x5D)

/* GPIO PORT Registers */
#define PORTB	(*(volatile unsigned char *) 0x25)
#define PORTC	(*(volatile unsigned char *) 0x28)
#define PORTD	(*(volatile unsigned char *) 0x2B)

/* GPIO Data Direction Register */
#define DDRB	(*(volatile unsigned char *) 0x24)
#define DDRC	(*(volatile unsigned char *) 0x27)
#define DDRD	(*(volatile unsigned char *) 0x2A)

/* GPIO Input Pin Register */
#define PINB	(*(volatile unsigned char *) 0x23)
#define PINC	(*(volatile unsigned char *) 0x26)
#define PIND	(*(volatile unsigned char *) 0x29)

/* Interrupt registers - external interrupts */
#define EICRA	(*(volatile unsigned char *) 0x69)
#define EIMSK	(*(volatile unsigned char *) 0x3D)
#define EIFR	(*(volatile unsigned char *) 0x3C)

/* Interrupt registers - pin change interrupts */
#define PCICR	(*(volatile unsigned char *) 0x68)
#define PCMSK2	(*(volatile unsigned char *) 0x6D)
#define PCIFR	(*(volatile unsigned char *) 0x3B)
#define PCMSK2	(*(volatile unsigned char *) 0x6D)
#define PCMSK1	(*(volatile unsigned char *) 0x6C)
#define PCMSK0	(*(volatile unsigned char *) 0x6B)

/* USART */
#define UDR0	(*(volatile unsigned char *) 0xC6)	/* USART I/O Data Register		*/
#define UCSR0A	(*(volatile unsigned char *) 0xC0)	/* USART Control & Status Register 0 A 	*/
#define UCSR0B	(*(volatile unsigned char *) 0xC1)	/* USART Control & Status Register 0 B	*/
#define UCSR0C	(*(volatile unsigned char *) 0xC2)	/* USART Control & Status Rgesiter 0 C	*/
#define UBRR0L	(*(volatile unsigned char *) 0xC4)	/* USART Baud Rate 0 Register Low	*/
#define UBRR0H	(*(volatile unsigned char *) 0xC5)	/* USART Baud Rate 0 Register High	*/

/* USART Control bits */
/* UCSR0A */
#define RXC0	BIT7			/* USART Receive Complete	*/
#define TXC0	BIT6			/* USART Transmit Complete	*/
#define UDRE0	BIT5			/* USART Data Register Empty 	*/
#define FE0		BIT4			/* Frame Error			*/
#define DOR0	BIT3			/* Data OverRun			*/
#define UPE0	BIT2			/* USART Parity Error		*/
#define U2X0	BIT1			/* Double USART Transmission speed	*/
#define MPCM0	BIT0			/* Mulit-processor Communication Mode	*/

/* UCSR0B */
#define RXCIE0	BIT7			/* Rx Complete Interrupt Enable 0 */
#define TXCIE0	BIT6			/* Tx Complete Interrupt Enable 0 */
#define UDRIE0	BIT5			/* USART Data Register Empty Interrupt Enable */
#define RXEN0	BIT4			/* Rx Enable */
#define TXEN0	BIT3			/* Tx Enable */
#define UCSZ02	BIT2			/* Character Size 0 Bit 2 */
#define RXB80	BIT1			/* Receive Data Bit 8 0 */
#define TXB00	BIT0			/* Transmit Data Bit 8 0 */

/* UCSR0C */
#define UMSEL01	BIT7			/* USART Mode Select 0 Bit 1 */
#define UMSEL00 BIT6			/* USART Mode Select 0 Bit 0 */
#define UPM01	BIT5			/* USART Parity Mode 0 Bit 1 */
#define UPM00	BIT4			/* USART Parity Mode 0 Bit 0 */
#define USBS0	BIT3			/* USART Stop Bit Select */
#define UCSZ01	BIT2			/* Character Size 0 Bit 1 */
#define UCSZ00	BIT1			/* Character Size 0 Bit 0 */
#define UCPOL0	BIT0			/* Clock Polarity 0 */

/* EEPROM */
#define EEARH (*(volatile unsigned char *) 0x42)	/* EEPROM Address Register High */
#define EEARL (*(volatile unsigned char *) 0x41)	/* EEPROM Address Register Low 	*/
#define EEDR  (*(volatile unsigned char *) 0x40)	/* EEPROM Data Register 	*/
#define EECR  (*(volatile unsigned char *) 0x3F)	/* EEPROM Control Register 	*/

/* EEPROM Control bits */
#define EEPM1	BIT5					/* EEPROM Programming Mode Bit 1 */
#define EEPM0	BIT4					/* EEPROM Programming Mode Bit 0 */
#define	EERIE	BIT3					/* EEPROM Ready Interrupt Enable */
#define EEMPE	BIT2					/* EEPROM Master Write Enable	 */
#define EEPE	BIT1					/* EEPROM Write Enable		 */
#define EERE	BIT0					/* EEPROM Read Enable		 */

/* Power Management & Sleep Modes */
#define SMRC	(*(volatile unsigned char *) 0x53)	/* Sleep Mode Control Register */
#define PRR		(*(volatile unsigned char *) 0x64)	/* Power Reduction Register */

/* Power Management & Sleep Modes Control bits*/
#define PRUSART0	BIT1				/* Power Reduction USART0 */

#define BIT0	0
#define BIT1	1
#define BIT2	2
#define BIT3	3
#define BIT4	4
#define BIT5	5
#define BIT6	6
#define BIT7	7
#endif /* __ref_map_h__ */
