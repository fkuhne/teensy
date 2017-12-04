#
# Makefile to build my first Teensy application
#
# Felipe Kühne
# 11/23/2016
#

C_SRCS = $(wildcard src/*.c)
CPP_SRCS = $(wildcard src/*.cpp)
ASM_SRCS = $(wildcard src/*.S)
OBJS = $(C_SRCS:.c=.o) $(CPP_SRCS:.cpp=.o) $(ASM_SRCS:.S=.o)

# Paths
PWD = $(shell pwd)
HOME = $(PWD)/..
TOOLS_PATH = /usr/local/gcc-arm-none-eabi-4_8-20140725/bin
TOOLS_LIBS = /usr/local/gcc-arm-none-eabi-4_8-20140725/arm-none-eabi/lib
TEENSY_CORE_PATH = $(HOME)/teensyCore
TEENSY_CORE_SRC = $(TEENSY_CORE_PATH)/src
TEENSY_CORE_LIB = $(TEENSY_CORE_PATH)/lib
TEENSY_TOOLS_PATH = /Applications/Arduino.app/Contents/Java/hardware/tools
OUTPUT_DIR = $(PWD)/bin

# Target
NAME = teensyBlink
TARGET = $(OUTPUT_DIR)/$(NAME)

# Tools
CPP = $(TOOLS_PATH)/arm-none-eabi-g++
CC = $(TOOLS_PATH)/arm-none-eabi-gcc
OBJCOPY = $(TOOLS_PATH)/arm-none-eabi-objcopy
AR = $(TOOLS_PATH)/arm-none-eabi-ar
RM = rm -rf
TEENSY_UPLOADER = $(TEENSY_TOOLS_PATH)/teensy_post_compile

# Include
INCLUDE_DIRS = -I$(TEENSY_CORE_PATH)/include -I./include

# Options
OPTIMIZATION_OPTS = -O
WARNING_OPTS = -Wall
DEBUG_OPTS = -g
TARGET_OPTS = -mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16 -fsingle-precision-constant
CPP_OPTS = -fno-exceptions -felide-constructors -std=gnu++0x -fno-rtti
PREPROC_SYMBOLS = -D__MK66FX1M0__ -DTEENSYDUINO=131 -DARDUINO=10612 -DF_CPU=180000000 -DUSB_SERIAL -DLAYOUT_US_ENGLISH
ASM_OPTS = -x assembler-with-cpp
COMMON_OPTS = $(OPTIMIZATION_OPTS) $(DEBUG_OPTS) $(WARNING_OPTS) -ffunction-sections -fdata-sections -nostdlib -MMD

ASM_FLAGS = $(COMMON_OPTS) $(ASM_OPTS) $(TARGET_OPTS) $(PREPROC_SYMBOLS) $(INCLUDE_DIRS)
C_FLAGS = $(COMMON_OPTS) $(TARGET_OPTS) $(PREPROC_SYMBOLS) $(INCLUDE_DIRS)
CPP_FLAGS = $(COMMON_OPTS) $(CPP_OPTS) $(TARGET_OPTS) $(PREPROC_SYMBOLS) $(INCLUDE_DIRS)

LINKER_SCRIPT_FLAG = -T$(TEENSY_CORE_SRC)/mk66fx1m0.ld
LD_FLAGS = -O -Wl,--gc-sections,--relax,--defsym=__rtc_localtime=0 $(LINKER_SCRIPT_FLAG) $(TARGET_OPTS)
LD_FLAGS_LIBS = -L$(TEENSY_CORE_LIB) -larm_cortexM4lf_math -lm

ELFTOHEX_OPTS = -O ihex -R .eeprom
ELFTOEEP_OPTS = -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0

TEENSY_POST_COMPILE_OPTS = -file=$(NAME) -path=$(OUTPUT_DIR) -tools=$(TEENSY_TOOLS_PATH) -board=TEENSY36

# Rules

all: $(TARGET).hex

# Compile: create assembler files from C source files.
%.o: %.S
	$(CC) -c $(ASM_FLAGS) $< -o $@

# Compile: create object files from C++ source files.
%.o: %.cpp
	$(CPP) -c $(CPP_FLAGS) $< -o $@

# Compile: create object files from C source files.
%.o: %.c
	$(CC) -c $(C_FLAGS) $< -o $@

# Link: create ELF output file from library.
$(TARGET).elf: src/main.o
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(LD_FLAGS) -o $@ $< $(TEENSY_CORE_LIB)/libTeensyCore36.a $(LD_FLAGS_LIBS)

$(TARGET).eep: $(TARGET).elf
	$(OBJCOPY) $(ELFTOEEP_OPTS) $< $@

$(TARGET).hex: $(TARGET).elf $(TARGET).eep
	$(OBJCOPY) $(ELFTOHEX_OPTS) $< $@

upload: $(TARGET).hex
	$(TEENSY_UPLOADER) $(TEENSY_POST_COMPILE_OPTS)

clean:
	$(RM) $(OBJS) ./src/*.d $(OUTPUT_DIR)

PHONY: all clean
