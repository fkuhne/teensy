#
# Makefile to build Teensy 3.6 core static library
#
# It shall be linked to some Teensy application (another folder)
#
# Felipe Kühne
# 11/23/2016
#

C_SRCS = $(wildcard src/*.c)
CPP_SRCS = $(wildcard src/*.cpp)
ASM_SRCS = $(wildcard src/*.S)
OBJS = $(C_SRCS:.c=.o) $(CPP_SRCS:.cpp=.o) $(ASM_SRCS:.S=.o)

# Paths
#TOOLS_PATH = /usr/local/gcc-arm-none-eabi-4_8-20140725/bin
TOOLS_PATH = /usr/local/gcc-arm-none-eabi-5_4-2016q3/bin
INCLUDE_DIRS = -I./include
OUTPUT_DIR = ./lib

# Target
TARGET = $(OUTPUT_DIR)/libTeensyCore36.a

# Tools
CPP = $(TOOLS_PATH)/arm-none-eabi-g++
CC = $(TOOLS_PATH)/arm-none-eabi-gcc
OBJCOPY = $(TOOLS_PATH)/arm-none-eabi-objcopy
AR = $(TOOLS_PATH)/arm-none-eabi-ar
RM = rm -rf

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

# Rules

all: $(TARGET)

# Compile: create assembler files from C source files.
%.o: %.S
	$(CC) -c $(ASM_FLAGS) $< -o $@

# Compile: create object files from C++ source files.
%.o: %.cpp
	$(CPP) -c $(CPP_FLAGS) $< -o $@

# Compile: create object files from C source files.
%.o: %.c
	$(CC) -c $(C_FLAGS) $< -o $@


# Create the archive file
$(TARGET): $(OBJS)
	mkdir -p $(OUTPUT_DIR)
	@for i in $(OBJS); do \
		echo $(AR) rcs $(TARGET) $$i; \
		$(AR) rcs $(TARGET) $$i; \
	done

clean:
	$(RM) $(OBJS) ./src/*.d $(OUTPUT_DIR)

PHONY: all clean
