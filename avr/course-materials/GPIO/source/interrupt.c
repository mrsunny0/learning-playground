/* Do not change the sequence of these prototypes */
void __vector_table(void) __attribute__((naked, section(".init0")));
void __reset_isr(void) __attribute__((naked, section(".init0")));
void __do_copy(void) __attribute__((naked, section(".init0")));
void __do_clear_bss(void) __attribute__((naked, section(".init0")));
void __undef_isr(void) __attribute__((naked, section(".init0")));
void __exit(void) __attribute__((naked, section(".fini0")));

void __vector_table(void) {
	asm volatile("jmp __reset_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
	asm volatile("jmp __undef_isr"::);
}

void __reset_isr(void) {
	asm volatile("eor	r1, r1"::);
	asm volatile("out	0x3f, r1"::);
	asm volatile("ldi	r28, 0xFF"::);
	asm volatile("ldi	r29, 0x08"::);
	asm volatile("out	0x3e, r29"::);
	asm volatile("out	0x3d, r28"::);
	asm volatile("sei"::);
}

void __do_copy(void) {
	asm volatile("ldi r17, hi8(__data_end)"::);
	asm volatile("ldi r26, lo8(__data_start)"::);
	asm volatile("ldi r27, hi8(__data_start)"::);
	asm volatile("ldi r30, lo8(__data_load_start)"::);
	asm volatile("ldi r31, hi8(__data_load_start)"::);
	asm volatile("rjmp DATA_COPY_START"::);
	asm volatile("DATA_COPY_LOOP:	"::);
	asm volatile("lpm r0, Z+"::);
	asm volatile("st X+, r0"::);
	asm volatile("DATA_COPY_START:"::);	
	asm volatile("cpi r26, lo8(__data_end)"::);
	asm volatile("cpc r27, r17"::);
	asm volatile("brne DATA_COPY_LOOP"::);
	asm volatile("jmp __do_clear_bss"::);
}

void __do_clear_bss(void) {
	asm volatile("ldi r17, hi8(__bss_end)"::);
	asm volatile("ldi r26, lo8(__bss_start)"::);
	asm volatile("ldi r27, hi8(__bss_start)"::);
	asm volatile("rjmp BSS_COPY_START"::);
asm volatile("BSS_COPY_LOOP:"::);
	asm volatile("st X+, r1"::);
	asm volatile("BSS_COPY_START:"::);
	asm volatile("cpi r26, lo8(__bss_end)"::);
	asm volatile("cpc r27, r17"::);
	asm volatile("brne BSS_COPY_LOOP"::);
	asm volatile("call 	main"::);
	asm volatile("jmp 	__exit"::);
}

void __undef_isr(void) {
	asm volatile("jmp __vector_table"::);
}

#if 0
void __int0_isr(void) {
	asm volatile("in	r0, 0x3f" : :);
	asm volatile("push 	r0" : :);
	EIFR |= 0x01;
	PORTB |= 0x01;
	delay_ms(300);
	PORTB &= ~0x01;
	asm volatile("pop 	r0" : :);
	asm volatile("out	0x3f, r0"::);
	asm volatile("reti" : : );
}

#endif

void __exit(void) {
	asm volatile("cli"::);
	asm volatile("jmp __exit"::);
}


