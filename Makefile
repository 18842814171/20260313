# Makefile for RISC-V simulator project

CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -g \
           -Iinclude -Iinclude/utils -Iinclude/inst \
           -MMD -MP

LDFLAGS = 

SOURCES = \
    $(wildcard device/*.cpp) \
	$(wildcard core/*.cpp) \
	loader/loader.cpp 
	


# 所有物件檔
SOURCES_OBJS = $(SOURCES:.cpp=.o)

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
	$(CXX) $^ $(LDFLAGS) -o $@

# 通用編譯規則
%.o: %.cpp
	@echo "Compiling: $<"
	@mkdir -p $(dir $@)   
	$(CXX) $(CXXFLAGS) -c $< -o $@

# 自動依賴包含
-include $(DEP_FILES)

clean:
	rm -rf $(OBJS) $(DEP_FILES) $(TARGET) 

.PHONY: all clean debug

