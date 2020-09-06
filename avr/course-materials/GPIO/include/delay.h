#ifndef __DELAY_H__
#define __DELAY_H__

static __inline__ void delay_ms(unsigned int delay /* delay in milliseconds */) __attribute__((__always_inline__));
static __inline__ void delay_us(unsigned int delay /* delay in microseconds */) __attribute__((__always_inline__));


static inline void busy_wait(register unsigned short ticks) __attribute__((__always_inline__));

void delay_ms(unsigned int delay) {
	while(delay) {
		busy_wait(CPU_CLK/4E3);
		delay--;
	}
}

void delay_us(unsigned int delay) {
	while(delay) {
		busy_wait(CPU_CLK/4E6);
		delay--;
	}	
}

void busy_wait(register unsigned short ticks)
{
	__asm__ volatile (
		"1: sbiw %0,1" "\n\t"
		"brne 1b"
		: "=w" (ticks)
		: "0" (ticks)
	);
}

#endif /* __DELAY_H__ */
