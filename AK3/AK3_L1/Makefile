SDK_PREFIX?=arm-none-eabi-
CC = $(SDK_PREFIX)gcc
LD = $(SDK_PREFIX)ld
SIZE = $(SDK_PREFIX)size
OBJCOPY = $(SDK_PREFIX)objcopy
QEMU = ~/opt/xPacks/qemu-arm/xpack-qemu-arm-7.2.0-1/bin/qemu-system-gnuarmeclipse

BOARD ?= STM32F4-Discovery  # Визначення плати
MCU=STM32F407VG             # Визначення мікроконтролера
TARGET=firmware
CPU_CC=cortex-m4
TCP_ADDR=1234

deps = \
    start.S \
    lscript.ld

all: target

target:
	$(CC) -x assembler-with-cpp -c -O0 -g3 -mcpu=$(CPU_CC) -Wall start.S -o start.o 
	$(CC) start.o -mcpu=$(CPU_CC) -Wall --specs=nosys.specs -nostdlib -lgcc -T./lscript.ld -o $(TARGET).elf 
	$(OBJCOPY) -O binary -F elf32-littlearm $(TARGET).elf $(TARGET).bin  # Конвертація ELF у бінарний файл

qemu:
	$(QEMU) --verbose --verbose --board $(BOARD) --mcu $(MCU) -d unimp,guest_errors --image $(TARGET).bin --semihosting-config enable=on,target=native -gdb tcp::$(TCP_ADDR) -S  # Запуск у QEMU з емуляцією плати

clean:
	-rm *.o
	-rm *.elf
	-rm *.bin
