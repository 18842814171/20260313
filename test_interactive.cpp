/**
 * @file test_interactive.cpp
 * @brief RISC-V 模拟器交互式前端
 *
 * 提供命令行菜单界面，用于选择、编译和运行测试程序。
 * 核心模拟逻辑在 simulator.cpp 中实现。
 */

#include "simulator.hpp"
#include "utils/InstGenerator.hpp"
#include "utils/DeviceGenerator.hpp"
#include "utils/utils.hpp"
#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <bitset>
#include <cctype>
#include <algorithm>
#include <vector>
#include <cstdlib>
#include <ctime>



// ============================================================
// InteractiveApp
// ============================================================
class InteractiveApp {
public:
    void run() {
        show_welcome();
        main_menu_loop();
    }

private:
    void show_welcome() {
        std::cout << "\n========================================\n";
        std::cout << "  RISC-V Simulator - Interactive Frontend\n";
        std::cout << "========================================\n\n";
    }

    void print_main_menu() {
        std::cout << "\nMain Menu:\n";
        std::cout << "  1. Run a program\n";
        std::cout << "  2. Add instructions\n";
        std::cout << "  3. Create new device\n";
        std::cout << "  q. Quit\n";
        std::cout << "========================================\n";
        std::cout << "Select: ";
    }

    void main_menu_loop() {
        while (true) {
            print_main_menu();
            std::string choice;
            std::getline(std::cin, choice);

            if (choice == "1") {
                run_program_workflow();
            } else if (choice == "2") {
                add_instructions_workflow();
            } else if (choice == "3") {
                create_test_file();
            } else if (choice == "q" || choice == "Q") {
                std::cout << "Goodbye.\n";
                break;
            } else {
                std::cout << "Unknown option.\n";
            }
        }
    }

    void run_program_workflow() {
        std::cout << "\n========== Run Program ==========\n";
        std::cout << "Available ELF files in out/:\n";

        std::vector<std::string> elf_files;
        FILE* pipe = popen("ls -1 out/ 2>/dev/null", "r");
        if (!pipe) {
            std::cerr << "Error: Could not list files\n";
            return;
        }

        char buffer[128];
        while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
            std::string filename(buffer);
            size_t pos = filename.find_last_not_of("\n\r");
            if (pos != std::string::npos) filename = filename.substr(0, pos + 1);
            if (!filename.empty() && filename[0] != '.' &&
                (filename.find(".o") == std::string::npos)) {
                elf_files.push_back(filename);
            }
        }
        pclose(pipe);

        if (elf_files.empty()) {
            std::cout << "No files found in out/\n";
            return;
        }

        for (size_t i = 0; i < elf_files.size(); ++i) {
            std::cout << "  " << (i + 1) << ". " << elf_files[i] << "\n";
        }

        std::cout << "\nEnter number (1-" << elf_files.size() << ") or path: ";
        std::string input;
        std::getline(std::cin, input);

        std::string path;
        if (input.empty()) return;

        int selection = 0;
        try {
            selection = std::stoi(input);
            if (selection >= 1 && selection <= static_cast<int>(elf_files.size())) {
                path = "out/" + elf_files[selection - 1];
            } else {
                std::cerr << "Error: Number out of range\n";
                return;
            }
        } catch (...) {
            path = input;
        }

        std::cout << "  1. Normal mode (auto run with UART input)\n";
        std::cout << "  2. Step-by-step mode (press 'n' to step)\n";
        std::cout << "  q. Cancel\n";
        std::cout << "Choose: ";

        std::string mode;
        std::getline(std::cin, mode);

        if (mode == "1") {
            std::cout << "\nRunning (auto run)...\n";
            std::cout << "Note: UART input is enabled for program interaction.\n\n";
            LogRedirector log;
            if (log.start(path)) {
                simulator_interactive(path, true, true);
                log.stop();
            } else {
                std::cerr << "Warning: could not open log file, output only to terminal.\n";
                simulator_interactive(path, true, true);
            }
        } else if (mode == "2") {
            std::cout << "\nRunning (step-by-step)...\n";
            std::cout << "Press 'n' to step, 'c' to switch to continuous mode.\n\n";
            simulator_interactive(path, true, false);  // enable_uart=true, auto_run=false
        } else {
            std::cout << "Cancelled.\n";
        }
    }

    
    void add_instructions_workflow() {
        InstGenerator gen;
        gen.generate();
    }

    void create_test_file() {
        DeviceGenerator gen;
        gen.generate();
    }
};

// ============================================================
// Main entry point
// ============================================================
int main(int argc, char* argv[]) {
    if (argc > 1 && std::string(argv[1]) == "-i" && argc > 2) {
        // Direct interactive mode
        std::string elf = argv[2];
        std::cout << "Running in interactive mode: " << elf << "\n";
        LogRedirector log;
        if (log.start(elf)) {
            simulator_interactive(elf, true, true);
            log.stop();
        } else {
            std::cerr << "Warning: could not open log file.\n";
            simulator_interactive(elf, true, true);
        }
    } else if (argc > 1) {
        // Direct non-interactive mode
        std::string elf = argv[1];
        std::cout << "Running: " << elf << "\n";
        simulator(elf, 0);
    } else {
        InteractiveApp app;
        app.run();
    }
    return 0;
}
