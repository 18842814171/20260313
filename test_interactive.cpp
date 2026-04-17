/**
 * @file test_interactive.cpp
 * @brief RISC-V 模拟器交互式前端
 *
 * 提供命令行菜单界面，用于选择、编译和运行测试程序。
 * 核心模拟逻辑在 simulator.cpp 中实现。
 */

#include "simulator.hpp"
#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>

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
                compile_workflow();
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
        system("ls -lh out/ ");

        std::cout << "\nEnter ELF file path (e.g., out/timer_uart_test) or empty to cancel: ";
        std::string path;
        std::getline(std::cin, path);

        if (path.empty()) return;

        // Check file exists
        std::ifstream f(path, std::ios::binary);
        if (!f.good()) {
            std::cerr << "Error: File not found: " << path << "\n";
            return;
        }
        f.close();

        std::cout << "\nSelect mode:\n";
        std::cout << "  1. Normal mode (auto run with UART input)\n";
        std::cout << "  2. Step-by-step mode (press 'n' to step)\n";
        std::cout << "  q. Cancel\n";
        std::cout << "Choose: ";

        std::string mode;
        std::getline(std::cin, mode);

        if (mode == "1") {
            std::cout << "\nRunning (auto run)...\n";
            std::cout << "Note: UART input is enabled for program interaction.\n\n";
            simulator_interactive(path, true, true);   // enable_uart=true, auto_run=true
        } else if (mode == "2") {
            std::cout << "\nRunning (step-by-step)...\n";
            std::cout << "Press 'n' to step, 'c' to switch to continuous mode.\n\n";
            simulator_interactive(path, true, false);  // enable_uart=true, auto_run=false
        } else {
            std::cout << "Cancelled.\n";
        }
    }

    void compile_workflow() {
        std::cout << "\n========== Compile Source ==========\n";
        std::cout << "Source files in tests/:\n";
        system("ls -lh tests/ ");
        std::cout << "\nEnter source file path (e.g., tests/hello.c) or empty to cancel: ";
        std::string path;
        std::getline(std::cin, path);

        if (path.empty()) return;

        // Check file
        std::ifstream f(path);
        if (!f.good()) {
            std::cerr << "Error: File not found: " << path << "\n";
            return;
        }
        f.close();

        std::string cmd = "./compile.sh c " + path + " 2>&1";
        std::cout << "\nCompiling...\n";
        int ret = system(cmd.c_str());

        if (ret == 0) {
            std::cout << "Compilation successful!\n";
        } else {
            std::cout << "Compilation failed.\n";
        }
    }

    void create_test_file() {
        std::cout << "\n========== Create Test File ==========\n";
        std::cout << "Enter new filename (e.g., mytest.c): ";
        std::string name;
        std::getline(std::cin, name);

        if (name.empty()) return;

        if (name.find(".c") == std::string::npos) {
            name += ".c";
        }
        std::string path = "tests/" + name;

        // Check exists
        std::ifstream check(path);
        if (check.good()) {
            std::cout << "File exists. Overwrite? (y/n): ";
            std::string ans;
            std::getline(std::cin, ans);
            if (ans != "y" && ans != "Y") {
                std::cout << "Cancelled.\n";
                return;
            }
        }

        // Copy template
        std::ifstream src("tests/program_test_device.c", std::ios::binary);
        if (!src.is_open()) {
            std::cerr << "Error: Cannot open template: tests/program_test_device.c\n";
            return;
        }
        std::ofstream dst(path, std::ios::binary);
        if (!dst.is_open()) {
            std::cerr << "Error: Cannot create: " << path << "\n";
            return;
        }
        dst << src.rdbuf();
        src.close();
        dst.close();

        std::cout << "Created: " << path << "\n";

        std::cout << "\nOpen editor? (y/n): ";
        std::string edit;
        std::getline(std::cin, edit);
        if (edit == "y" || edit == "Y") {
            const char* editor = std::getenv("EDITOR");
            if (!editor) editor = "nano";
            std::string cmd = std::string(editor) + " " + path;
            system(cmd.c_str());

            std::cout << "\nCompile now? (y/n): ";
            std::string compile;
            std::getline(std::cin, compile);
            if (compile == "y" || compile == "Y") {
                std::string ccmd = "./compile.sh c " + path + " 2>&1";
                system(ccmd.c_str());
            }
        }
    }
};

// Main entry point
int main(int argc, char* argv[]) {
    if (argc > 1 && std::string(argv[1]) == "-i" && argc > 2) {
        // Direct interactive mode
        std::string elf = argv[2];
        std::cout << "Running in interactive mode: " << elf << "\n";
        simulator_interactive(elf, true);
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
