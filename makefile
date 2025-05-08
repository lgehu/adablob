MAIN ?= adablob
DATABLOB=datablob
#PRJ_NAME ?= ecg_sensor

# Toolchain
CC = arm-eabi-gcc
OBJCOPY = arm-eabi-objcopy
STFLASH = st-flash

# Build directory
BUILD_DIR = obj
BIN_DIR = bin

ADDR ?= 0x08060000

# Default target
all: compile flash

# Compile the project
compile:
	alr build -- -XMAIN=$(MAIN) -v 
	alr exec -- arm-eabi-gcc -nostartfiles -Wl,-T linker/linker_script.ld -o bin/$(DATABLOB) obj/$(DATABLOB).o -Wl,'--defsym=DATA_ADDR=$(ADDR)'
	alr exec -- arm-eabi-objcopy -O binary -j .custom_data bin/$(DATABLOB) bin/$(DATABLOB).bin
	# alr exec -- $(OBJCOPY) -O binary $(BIN_DIR)/$(MAIN) $(BIN_DIR)/$(MAIN).bin

# Flash the binary to the board
flash:
	$(STFLASH) write $(BIN_DIR)/$(DATABLOB).bin $(ADDR)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)/*
	rm -rf $(BIN_DIR)/*
	alr exec -- gprclean

.PHONY: all compile flash clean
