/**
 * @file test.cpp - 模拟器测试入口
 *
 * 本文件是 RISC-V 模拟器的测试入口程序。
 * 用户可通过命令行参数选择不同的测试模式。
 *
 * 使用方式:
 *   ./build/test [OPTIONS]
 */

#include "SimulatorAPI.hpp"
#include <iostream>
#include <cstring>

void print_usage(const char* program) {
    std::cout << "RISC-V 模拟器测试程序\n\n";
    std::cout << "用法: " << program << " [OPTIONS] <file>\n\n";
    std::cout << "选项:\n";
    std::cout << "  --e0 <file>    运行 ELF 程序：输入二进制程序\n";
    std::cout << "  --e1 <file>    运行完整程序（含设备）：输入c程序\n";
    std::cout << "  --e2 <file>    测试外部设备：输入测试c程序\n";
    std::cout << "  --help, -h     显示帮助信息\n\n";
    
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        print_usage(argv[0]);
        return 1;
    }
    
    std::string option = argv[1];
    
    if (option == "--help" || option == "-h") {
        print_usage(argv[0]);
        return 0;
    }
    else if (option == "--e0") {
        if (argc < 3) {
            std::cerr << "错误: --e0 需要指定文件\n";
            return 1;
        }
        test_simple_asm(argv[2]);
    }
    else if (option == "--e1") {
        if (argc < 3) {
            std::cerr << "错误: --e1 需要指定文件\n";
            return 1;
        }
        test_full_program(argv[2]);
    }
    else if (option == "--e2") {
        if (argc < 3) {
            std::cerr << "错误: --e2 需要指定文件\n";
            return 1;
        }
        test_ext_device(argv[2]);
    }
    else {
        std::cerr << "未知选项: " << option << "\n";
        print_usage(argv[0]);
        return 1;
    }
    
    return 0;
}