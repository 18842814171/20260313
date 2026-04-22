# Makefile for RISC-V simulator project

CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -g \
           -Iinclude -Iinclude/utils -Iinclude/inst -Iinclude/device\
           -MMD -MP

LDFLAGS =

BUILD_DIR = build

SOURCES = \
    $(wildcard device/*.cpp) \
	$(wildcard core/*.cpp) \
	loader/loader.cpp 



# Result: build/cpu.o build/memory.o build/loader.o
SOURCES_OBJS = $(addprefix $(BUILD_DIR)/, $(notdir $(SOURCES:.cpp=.o)))

DEP_FILES = $(SOURCES_OBJS:.o=.d) 
# 主程式目標
TARGET = $(BUILD_DIR)/test

# 預設目標：編譯測試程式
all: $(TARGET)

# 測試程式
$(TARGET): $(SOURCES_OBJS) test.cpp
	@echo "Compiling test.cpp ..."
	$(CXX) $(CXXFLAGS) test.cpp \
		build/Bus.o build/Memory.o build/Timer.o build/UART.o build/ALU.o build/CPU.o \
		build/Decoder.o build/Instmngr.o build/Interrupt.o \
		build/simulator.o build/simulator_api.o build/loader.o \
		-lpthread $(LDFLAGS) -o $@
	@echo "Run: ./$(TARGET)"

# Clean only object files, keep simulator.o for main build
clean_objs:
	rm -f build/*.o
	touch build/.keep

# 通用編譯規則
# VPATH tells Make where to look for source files if they aren't in the current dir
VPATH = $(sort $(dir $(SOURCES)))

# Pattern rule: build/%.o depends on %.cpp (found via VPATH)
$(BUILD_DIR)/%.o: %.cpp
	@echo "Compiling: $<"
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# 自動依賴包含
-include $(DEP_FILES)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean debug test

