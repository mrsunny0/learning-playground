MCU = atmega328p
CLK_SPEED = 16000000
AVR_ARCH = avr5

AD_MCU = m328p
PRGMR = arduino
PORT = COM5
BAUDRATE = 115200

INC_DIR = ..\include
LNKR_SCRIPT = ..\linker

GCC = avr-gcc
LD = avr-ld
OC = avr-objcopy
OD = avr-objdump
AD = avrdude
RM = del

GCC_FLAGS = -c -I$(INC_DIR) -DCPU_CLK=$(CLK_SPEED) -mmcu=$(MCU) -g -Os
LD_FLAGS =  -A$(AVR_ARCH) -nostartfiles -nodefaultlibs -T$(LNKR_SCRIPT)
OC_FLAGS = -j .text -j .data -O
OD_FLAGS = -DS
AD_FLAGS = -p$(AD_MCU) -c$(PRGMR) -P$(PORT) -b$(BAUDRATE)

C_SRC = prog.c  interrupt.c usart.c util.c
ASM_SRC = 
TARGET = gpio

OBJS  = $(C_SRC:.c=.o) $(ASM_SRC:.S=.o)

build : elf hex asm

elf : $(TARGET).elf 
hex : $(TARGET).hex 
asm : $(TARGET).asm

%.o : %.c
	$(GCC) $(GCC_FLAGS) $< -o $@
	
%.o : %.S
	$(GCC) $(GCC_FLAGS) $< -o $@	
	
$(TARGET).elf : $(OBJS)
	$(LD) $(LD_FLAGS) $^ -o $@
	
$(TARGET).hex : $(TARGET).elf
	$(OC) $(OC_FLAGS) ihex $< $@
	
$(TARGET).asm : $(TARGET).elf
	$(OD) $(OD_FLAGS) $< > $@
	
flash : $(TARGET).hex
	$(AD) $(AD_FLAGS) -Uflash:w:$<:i
	
.PHONY = clean

clean :
	$(RM) *.o *.asm *.hex *.elf
