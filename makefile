MAIN ?= adablob
DATABLOB = datablob
DATAFILE ?= 
#PRJ_NAME ?= ecg_sensor

# Toolchain
CC = arm-eabi-gcc
OBJCOPY = arm-eabi-objcopy
STFLASH = st-flash

# Build directory
BUILD_DIR = obj
BIN_DIR = bin

ADDR ?= 0x08060000
DATA_LENGTH ?= 4096

# Default target
all: compile flash

# Compile the project
compile:
	st-flash write $(DATAFILE) $(ADDR)
	#alr exec -- $(OBJCOPY) -I binary -O elf32-littlearm -B arm --rename-section .data=.rodata $(DATAFILE) $(BUILD_DIR)/$(DATAFILE).o
	#alr exec -- $(OBJCOPY) -O binary $(BUILD_DIR)/$(DATAFILE).o $(BIN_DIR)/a.bin

# Flash the binary to the board
flash:
	$(STFLASH) write $(BIN_DIR)/$(DATABLOB).bin $(ADDR)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)/*
	rm -rf $(BIN_DIR)/*
	alr exec -- gprclean

.PHONY: all compile flash clean
