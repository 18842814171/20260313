// test.cpp - Test interface for simulator
#include "SimulatorAPI.hpp"
#include <iostream>
#include <cstring>

void print_usage(const char* program) {
    std::cout << "Usage: " << program << " [OPTIONS]\n\n";
    std::cout << "Test options:\n";
    std::cout << "  --e0 [file]    Execute simple assembly program (default: tests/simple_asm.s)\n";
    std::cout << "  --e1 <file>    Run compiled full program\n";
    std::cout << "  --e2           Test interrupt functionality\n";
    std::cout << "  --e3 <file>    Run tests with external device\n";
    std::cout << "\nExamples:\n";
    std::cout << "  " << program << " --e0\n";
    std::cout << "  " << program << " --e0 tests/simple_asm.s\n";
    std::cout << "  " << program << " --e1 out/simple32\n";
    std::cout << "  " << program << " --e2\n";
    std::cout << "  " << program << " --e3 out/simple32\n";
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
        std::string asm_file = "tests/simple_asm.s";
        if (argc >= 3) {
            asm_file = argv[2];
        }
        test_simple_asm(asm_file);
    }
    else if (option == "--e1") {
        if (argc < 3) {
            std::cerr << "Error: --e1 requires a file argument\n";
            return 1;
        }
        test_full_program(argv[2]);
    }
    else if (option == "--e2") {
        test_interrupt();
    }
    else if (option == "--e3") {
        if (argc < 3) {
            std::cerr << "Error: --e3 requires a file argument\n";
            return 1;
        }
        test_ext_device(argv[2]);
    }
    else {
        std::cerr << "Unknown option: " << option << "\n";
        print_usage(argv[0]);
        return 1;
    }
    
    return 0;
}
