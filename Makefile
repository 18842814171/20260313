# Makefile for RISC-V simulator project

CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -g \
           -Iinclude -Iinclude/utils -Iinclude/inst \
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
TARGET = simulator

# 測試目標（可執行檔）
#TEST_TARGETS = build/run 

# 預設目標：產生主程式 
all: $(TARGET) 

# 主模擬器
$(TARGET): $(SOURCES_OBJS)
	@echo "Linking $@ ..."
	$(CXX) $(SOURCES_OBJS) $(LDFLAGS) -o $@

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
	rm -rf $(SOURCES_OBJS) $(DEP_FILES) $(TARGET) 

.PHONY: all clean debug

