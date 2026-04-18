/**
 * @file DeviceGenerator.hpp
 * @brief 设备生成器 - 交互式创建设备的工具
 */
#ifndef DEVICE_GENERATOR_HPP
#define DEVICE_GENERATOR_HPP

#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <sstream>

class DeviceGenerator {
public:
    void generate() {
        std::cout << "\n========== Create New Device ==========\n";
        std::cout << "This wizard will help you create a new device.\n\n";

        // Step 1: 收集参数
        std::string device_name = input_device_name();
        if (device_name.empty()) return;

        std::string mmio_addr = input_mmio_addr();

        // Step 2: 生成设备头文件
        generate_hpp(device_name, mmio_addr);

        // Step 3: 生成测试程序
        generate_test_c(device_name, mmio_addr);

        // Step 4: 自动注册代码
        print_registration_code(device_name);

        // Step 5: 编译帮助
        print_compile_help(device_name);

        std::cout << "\nPress Enter to continue...";
        std::cin.get();
    }

private:
    std::string input_device_name() {
        std::cout << "Enter device name (e.g., GPIO, PWM, SPI): ";
        std::string name;
        std::getline(std::cin, name);

        if (name.empty()) {
            std::cout << "Cancelled.\n";
            return "";
        }

        for (auto& c : name) c = std::tolower(c);
        name[0] = std::toupper(name[0]);

        return name;
    }

    std::string input_mmio_addr() {
        std::cout << "\nEnter MMIO base address (hex, e.g., 20000000): ";
        std::string addr;
        std::getline(std::cin, addr);

        if (addr.empty()) addr = "20000000";

        return addr;
    }

    void generate_hpp(const std::string& name, const std::string& addr) {
        std::string upper = name;
        std::transform(upper.begin(), upper.end(), upper.begin(), ::toupper);

        std::string cap = name;
        cap[0] = std::toupper(cap[0]);

        std::string hpp_path = "include/device/" + name + ".hpp";

        std::ifstream check(hpp_path);
        if (check.good()) {
            check.close();
            std::cout << "\nWarning: " << hpp_path << " exists. Skip? (y/n): ";
            std::string ans;
            std::getline(std::cin, ans);
            if (ans == "y" || ans == "Y") return;
        }
        check.close();

        std::ofstream out(hpp_path);
        if (!out.is_open()) {
            std::cerr << "Error: Cannot create " << hpp_path << "\n";
            return;
        }

        out << "/**\n";
        out << " * @file " << name << ".hpp\n";
        out << " * @brief " << name << " Device Driver\n";
        out << " *\n";
        out << " * Device address: 0x" << addr << "\n";
        out << " */\n";
        out << "#ifndef " << upper << "_HPP\n";
        out << "#define " << upper << "_HPP\n\n";
        out << "#include \"device/Device.hpp\"\n\n";
        out << "/**\n";
        out << " * @brief " << name << " Device\n";
        out << " *\n";
        out << " * Registers:\n";
        out << " *   REG_CTRL   (0x00): Control register\n";
        out << " *   REG_STATUS (0x04): Status register\n";
        out << " *   REG_DATA   (0x08): Data register\n";
        out << " */\n";
        out << "class " << cap << " : public Device {\n";
        out << "private:\n";
        out << "    static constexpr uint32_t REG_CTRL   = 0x00;\n";
        out << "    static constexpr uint32_t REG_STATUS = 0x04;\n";
        out << "    static constexpr uint32_t REG_DATA   = 0x08;\n\n";
        out << "    uint32_t control = 0;\n";
        out << "    uint32_t status = 0;\n";
        out << "    uint32_t data_reg = 0;\n\n";
        out << "public:\n";
        out << "    " << cap << "() {}\n\n";
        out << "    void write(uint32_t addr, uint8_t* data, size_t size) override {\n";
        out << "        if (size != 4) return;\n";
        out << "        uint32_t value = bytes_to_word(data);\n\n";
        out << "        switch (addr) {\n";
        out << "            case REG_CTRL:   control = value; break;\n";
        out << "            case REG_STATUS: status = value; break;\n";
        out << "            case REG_DATA:   data_reg = value; break;\n";
        out << "        }\n";
        out << "    }\n\n";
        out << "    void read(uint32_t addr, uint8_t* data, size_t size) override {\n";
        out << "        if (size != 4) return;\n";
        out << "        uint32_t value = 0;\n\n";
        out << "        switch (addr) {\n";
        out << "            case REG_CTRL:   value = control; break;\n";
        out << "            case REG_STATUS: value = status; break;\n";
        out << "            case REG_DATA:   value = data_reg; break;\n";
        out << "        }\n";
        out << "        word_to_bytes(value, data);\n";
        out << "    }\n";
        out << "};\n\n";
        out << "#endif // " << upper << "_HPP\n";

        out.close();
        std::cout << "\nGenerated: " << hpp_path << "\n";
    }

    void generate_test_c(const std::string& name, const std::string& addr) {
        std::string upper = name;
        std::transform(upper.begin(), upper.end(), upper.begin(), ::toupper);

        std::string test_path = "tests/" + name + "_test.c";

        std::ifstream check(test_path);
        if (check.good()) {
            check.close();
            std::cout << "Warning: " << test_path << " exists. Skip? (y/n): ";
            std::string ans;
            std::getline(std::cin, ans);
            if (ans == "y" || ans == "Y") return;
        }
        check.close();

        std::ofstream out(test_path);
        if (!out.is_open()) {
            std::cerr << "Error: Cannot create " << test_path << "\n";
            return;
        }

        out << "/**\n";
        out << " * @file " << name << "_test.c\n";
        out << " * @brief " << name << " Device Test Program\n";
        out << " *\n";
        out << " * Device address: 0x" << addr << "\n";
        out << " */\n\n";
        out << "#include <stdint.h>\n\n";
        out << "/* Device Registers */\n";
        out << "#define " << upper << "_BASE   0x" << addr << "\n";
        out << "#define REG_CTRL                     0x00\n";
        out << "#define REG_STATUS                   0x04\n";
        out << "#define REG_DATA                     0x08\n\n";
        out << "/* Helper macros */\n";
        out << "#define REG(offset) ((volatile uint32_t*)(" << upper << "_BASE + (offset)))\n\n";
        out << "int main() {\n";
        out << "    /* Initialize device */\n";
        out << "    *REG(REG_CTRL) = 0x01;\n\n";
        out << "    /* Read status */\n";
        out << "    uint32_t status = *REG(REG_STATUS);\n\n";
        out << "    /* Main loop - customize for your device */\n";
        out << "    for (int i = 0; i < 10; i++) {\n";
        out << "        *REG(REG_DATA) = i;\n";
        out << "        while ((*REG(REG_STATUS) & 0x01) == 0) {\n";
        out << "            asm volatile(\"nop\");\n";
        out << "        }\n";
        out << "    }\n\n";
        out << "    /* Exit (RISC-V ecall) */\n";
        out << "    asm volatile(\"li a7, 93\");\n";
        out << "    asm volatile(\"li a0, 0\");\n";
        out << "    asm volatile(\"ecall\");\n\n";
        out << "    while(1);\n";
        out << "    return 0;\n";
        out << "}\n";

        out.close();
        std::cout << "Generated: " << test_path << "\n";
    }

    void print_registration_code(const std::string& name) {
        std::string upper = name;
        std::transform(upper.begin(), upper.end(), upper.begin(), ::toupper);

        std::cout << "\n========== Registration Steps ==========\n";
        std::cout << "\nTo register the device, add this to core/simulator_api.cpp:\n\n";
        std::cout << "1. Add include:\n";
        std::cout << "   #include \"device/" << name << ".hpp\"\n\n";
        std::cout << "2. Add device instance (static recommended):\n";
        std::cout << "   static " << name << " " << name << "_instance;\n\n";
        std::cout << "3. Attach to bus:\n";
        std::cout << "   bus->attach_device(0x" << upper << "_ADDR, &" << name << "_instance);\n\n";
    }

    void print_compile_help(const std::string& name) {
        std::cout << "\n========== Compile Help ==========\n\n";
        std::cout << "To compile and run your device test:\n\n";
        std::cout << "1. Compile:\n";
        std::cout << "   ./compile.sh c tests/" << name << "_test.c\n\n";
        std::cout << "2. Run:\n";
        std::cout << "   ./simulator out/" << name << "_test\n\n";
        std::cout << "3. Or use interactive mode:\n";
        std::cout << "   ./test_interactive\n";
        std::cout << "   -> Select '1. Run a program'\n";
        std::cout << "   -> Enter: out/" << name << "_test\n\n";
        std::cout << "Note: Make sure to add device registration in simulator_api.cpp\n";
        std::cout << "      before running, otherwise memory access will fail.\n";
    }
};

#endif // DEVICE_GENERATOR_HPP
