/**
 * @file test_interactive.cpp
 * @brief 交互式设备测试程序
 *
 * 提供交互式界面来测试 Timer 和 UART 设备。
 * 用户可以通过命令行菜单与模拟器中的设备直接交互。
 */

#include "SimulatorAPI.hpp"
#include "CPU.hpp"
#include "device/Timer.hpp"
#include "device/UART.hpp"
#include "device/Bus.hpp"

#include "Instmngr.hpp"
#include "Loader.hpp"
#include "utils/utils.hpp"
#include <iostream>
#include <iomanip>
#include <sstream>
#include <string>
#include <fstream>
#include <thread>
#include <chrono>
#include <atomic>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>

// 交互式测试类
class InteractiveDeviceTest {
private:
    CPU* cpu;
    Memory* mem;
    InstManager* im;
    Bus* bus;
    Timer* timer;
    UART* uart;
    bool running;
    std::thread uart_input_thread;
    std::atomic<bool> input_thread_running;
    std::atomic<bool> char_available;
    std::atomic<uint8_t> pending_char;

public:
    InteractiveDeviceTest() 
        : cpu(nullptr), mem(nullptr), im(nullptr), bus(nullptr)
        , timer(nullptr), uart(nullptr), running(false)
        , input_thread_running(false), char_available(false), pending_char(0) {
    }

    ~InteractiveDeviceTest() {
        cleanup();
    }

    void cleanup() {
        running = false;
        input_thread_running = false;
        if (uart_input_thread.joinable()) {
            uart_input_thread.join();
        }
        cleanup_cpu(cpu, mem, im);
    }

    // 初始化模拟器
    bool init(const std::string& elf_file) {
        im = new InstManager();
        register_all_instructions(im);

        mem = new Memory();
        cpu = new CPU(*mem, *im);

        // 设置中断控制器
        static InterruptController int_ctrl;
        static TrapHandler trap;
        cpu->set_interrupt_controller(&int_ctrl);
        cpu->set_trap_handler(&trap);
        cpu->enable_interrupts();

        // 加载 ELF
        try {
            uint32_t entry = load_elf(elf_file, *mem);
            cpu->set_pc(entry);
            cpu->reg[0] = 0;
            cpu->reg[2] = 0x20000;
            cpu->reg[10] = 0;
            cpu->reg[17] = 0;
        } catch (const std::exception& e) {
            std::cerr << "Failed to load ELF: " << e.what() << "\n";
            return false;
        }

        // 设置总线和设备
        bus = new Bus();
        bus->attach_memory(mem);

        timer = new Timer();
        bus->attach_device(0x02004000, timer);

        uart = new UART();
        bus->attach_device(0x10000000, uart);

        cpu->attach_bus(bus);

        return true;
    }

    // 初始化无 ELF 的裸机测试
    bool init_bare_metal() {
        im = new InstManager();
        register_all_instructions(im);

        mem = new Memory();
        cpu = new CPU(*mem, *im);

        static InterruptController int_ctrl;
        static TrapHandler trap;
        cpu->set_interrupt_controller(&int_ctrl);
        cpu->set_trap_handler(&trap);
        cpu->enable_interrupts();

        // 设置总线和设备
        bus = new Bus();
        bus->attach_memory(mem);

        timer = new Timer();
        timer->reset();
        bus->attach_device(0x02004000, timer);

        uart = new UART();
        uart->reset();
        bus->attach_device(0x10000000, uart);

        cpu->attach_bus(bus);

        // 设置一个简单的无限循环 PC
        cpu->set_pc(0x2000);
        cpu->reg[0] = 0;
        cpu->halt = true;  // 保持 halt 状态直到用户运行程序

        return true;
    }

    // 设置终端为原始模式以读取单个按键
    void set_raw_mode() {
        struct termios ttystate;
        tcgetattr(STDIN_FILENO, &ttystate);
        ttystate.c_lflag &= ~(ICANON | ECHO);
        ttystate.c_cc[VMIN] = 0;
        ttystate.c_cc[VTIME] = 0;
        tcsetattr(STDIN_FILENO, TCSANOW, &ttystate);
    }

    // 恢复终端模式
    void restore_terminal() {
        struct termios ttystate;
        tcgetattr(STDIN_FILENO, &ttystate);
        ttystate.c_lflag |= ICANON | ECHO;
        tcsetattr(STDIN_FILENO, TCSANOW, &ttystate);
    }

    // UART 输入线程
    void uart_input_loop() {
        set_raw_mode();
        while (input_thread_running) {
            char c;
            int n = read(STDIN_FILENO, &c, 1);
            if (n > 0) {
                pending_char = static_cast<uint8_t>(c);
                char_available = true;
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(10));
        }
        restore_terminal();
    }

    // 启动 UART 输入监听
    void start_uart_input() {
        if (!input_thread_running) {
            input_thread_running = true;
            uart_input_thread = std::thread(&InteractiveDeviceTest::uart_input_loop, this);
        }
    }

    // 停止 UART 输入监听
    void stop_uart_input() {
        input_thread_running = false;
        if (uart_input_thread.joinable()) {
            uart_input_thread.join();
        }
    }

    // 处理 UART 输入（从键盘到 UART RX）
    void process_uart_input() {
        while (has_pending_char()) {
            uint8_t c = get_pending_char();
            if (c == 3) {  // Ctrl+C
                std::cout << "\n中断程序执行...\n";
                cpu->halt = true;
                break;
            }
            uart->put_char(c);
        }
    }

    // 检查是否有待处理的字符
    bool has_pending_char() {
        return char_available.load();
    }

    // 获取待处理的字符
    uint8_t get_pending_char() {
        char_available = false;
        return pending_char.load();
    }

    // 打印帮助信息（主界面 - 3个选项）
    void print_main_menu() {
        std::cout << "\n";
        std::cout << "================================\n";
        std::cout << "  主菜单\n";
        std::cout << "  1. 运行程序\n";
        std::cout << "  2. 增加指令\n";
        std::cout << "  3. 增加外设\n";
        std::cout << "  q. 退出\n";
        std::cout << "================================\n";
        std::cout << "\n选择操作: ";
    }

    // 打印帮助信息（用于单步/自动运行模式）
    void print_run_help() {
        std::cout << "\n";
        std::cout << "========== 运行模式 ==========\n";
        std::cout << "  输入 n     - 执行下一步\n";
        std::cout << "  输入数字   - 自动运行指定步数\n";
        std::cout << "  直接回车   - 自动运行至程序完成\n";
        std::cout << "  h/?       - 显示此帮助\n";
        std::cout << "  q         - 返回主菜单\n";
        std::cout << "============================\n";
        std::cout << "\n选择操作: ";
    }

    // 显示状态
    void show_status() {
        std::cout << "\n========== 系统状态 ==========\n";

        // CPU 状态
        std::cout << "CPU:\n";
        std::cout << "  PC: 0x" << std::hex << std::setfill('0') << std::setw(8) << cpu->pc << "\n";
        std::cout << "  Halt: " << (cpu->halt ? "Yes" : "No") << "\n";
        std::cout << "  Step count: " << std::dec << cpu->step_count << "\n";

        // Timer 状态
        std::cout << "\nTimer:\n";
        std::cout << "  MTIME: 0x" << std::hex << std::setfill('0') << std::setw(16) << timer->get_mtime() << "\n";
        std::cout << "  MTIMECMP: 0x" << std::hex << std::setfill('0') << std::setw(16) << timer->get_mtimecmp() << "\n";
        std::cout << "  Interrupt pending: " << (timer->check_interrupt() ? "Yes" : "No") << "\n";

        // UART 状态
        std::cout << "\nUART:\n";
        std::cout << "  TXCTRL: 0x" << std::hex << std::setfill('0') << std::setw(8) << uart->get_txctrl() << "\n";
        std::cout << "  RXCTRL: 0x" << std::hex << std::setfill('0') << std::setw(8) << uart->get_rxctrl() << "\n";
        std::cout << "  RX FIFO size: " << std::dec << uart->rx_count() << "\n";
        std::cout << "  Has received: " << (uart->has_received() ? "Yes" : "No") << "\n";
        std::cout << "  Interrupt pending: " << (uart->check_interrupt() ? "Yes" : "No") << "\n";

        std::cout << "\n=============================\n";
    }

    // Timer 测试
    void test_timer() {
        std::cout << "\n========== Timer 测试 ==========\n";

        // 测试 tick
        std::cout << "测试 tick()...\n";
        uint64_t before = timer->get_mtime();
        for (int i = 0; i < 10; i++) {
            timer->tick();
        }
        uint64_t after = timer->get_mtime();
        std::cout << "  Before: " << before << "\n";
        std::cout << "  After 10 ticks: " << after << "\n";

        // 测试中断
        std::cout << "\n测试中断...\n";
        timer->set_mtimecmp(timer->get_mtime() + 5);
        std::cout << "  Set MTIMECMP to mtime + 5\n";
        std::cout << "  check_interrupt(): " << (timer->check_interrupt() ? "Pending" : "Not pending") << "\n";

        // 触发中断
        for (int i = 0; i < 6; i++) {
            timer->tick();
        }
        std::cout << "  After 6 more ticks:\n";
        std::cout << "  check_interrupt(): " << (timer->check_interrupt() ? "Pending!" : "Not pending") << "\n";

        // 清除中断
        timer->clear_interrupt();
        std::cout << "  After clear_interrupt():\n";
        std::cout << "  check_interrupt(): " << (timer->check_interrupt() ? "Pending" : "Not pending") << "\n";

        std::cout << "\n===============================\n";
    }

    // UART 测试
    void test_uart() {
        std::cout << "\n========== UART 测试 ==========\n";

        // 测试发送
        std::cout << "测试发送字符...\n";
        uart->reset();
        uart->write(0x08, nullptr, 0);  // TXCTRL 地址
        uint32_t txctrl_val = 1;  // 启用发送
        uint8_t data[4] = {txctrl_val, 0, 0, 0};
        uart->write(0x08, data, 4);
        std::cout << "  Enabled TX, sent 'H', 'e', 'l', 'l', 'o':\n";
        std::cout << "  ";

        // 使用 UART 的 put_char 功能通过 TXDATA
        uint8_t ch_data[4] = {'H', 0, 0, 0};
        uart->write(0x00, ch_data, 4);  // TXDATA
        ch_data[0] = 'e';
        uart->write(0x00, ch_data, 4);
        ch_data[0] = 'l';
        uart->write(0x00, ch_data, 4);
        ch_data[0] = 'l';
        uart->write(0x00, ch_data, 4);
        ch_data[0] = 'o';
        uart->write(0x00, ch_data, 4);
        std::cout << "\n";

        // 测试接收
        std::cout << "\n测试接收...\n";
        uart->put_char('W');
        uart->put_char('o');
        uart->put_char('r');
        uart->put_char('l');
        uart->put_char('d');
        std::cout << "  Put 'World' into RX FIFO\n";
        std::cout << "  RX FIFO size: " << uart->rx_count() << "\n";

        uint8_t c;
        std::cout << "  Reading from RX FIFO: ";
        while (uart->get_char(c)) {
            std::cout << static_cast<char>(c);
        }
        std::cout << "\n";
        std::cout << "  RX FIFO size after read: " << uart->rx_count() << "\n";

        std::cout << "\n===============================\n";
    }

    // 发送字符到 UART
    void send_char_to_uart() {
        std::cout << "\n========== 发送字符到 UART ==========\n";
        std::cout << "输入要发送的字符 (输入 q 返回): ";

        std::string input;
        std::getline(std::cin, input);

        if (input == "q" || input.empty()) {
            std::cout << "取消发送.\n";
            return;
        }

        char c = input[0];
        uint8_t data[4] = {static_cast<uint8_t>(c), 0, 0, 0};
        uart->write(0x00, data, 4);  // TXDATA
        std::cout << "Sent: '" << c << "' (0x" << std::hex << static_cast<int>(c) << ")\n";

        std::cout << "\n====================================\n";
    }

    // 读取键盘输入到 UART RX FIFO
    void read_keyboard_to_uart() {
        std::cout << "\n========== 键盘输入模式 ==========\n";
        std::cout << "按任意键输入到 UART RX FIFO\n";
        std::cout << "按 'q' 或 Ctrl+C 退出此模式\n";
        std::cout << "\n启动原始模式键盘监听...\n\n";

        start_uart_input();

        // 实时处理输入
        while (true) {
            if (has_pending_char()) {
                uint8_t c = get_pending_char();

                if (c == 'q' - 'a' + 1) {  // Ctrl+C
                    std::cout << "\n退出键盘输入模式.\n";
                    break;
                }
                if (c == 'Q') {
                    std::cout << "\n退出键盘输入模式.\n";
                    break;
                }

                // 添加到 UART RX FIFO
                uart->put_char(c);

                // 显示输入
                if (c >= 32 && c < 127) {
                    std::cout << "RX: '" << static_cast<char>(c) << "' -> UART RX FIFO\n";
                } else {
                    std::cout << "RX: 0x" << std::hex << static_cast<int>(c) << " -> UART RX FIFO\n";
                }
            }

            // 显示当前 RX FIFO 状态
            if (uart->has_received()) {
                std::cout << "  [RX FIFO has " << uart->rx_count() << " char(s)]\n";
            }

            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }

        stop_uart_input();
        std::cout << "\n====================================\n";
    }

    // 内存/MMIO 测试
    void test_memory() {
        std::cout << "\n========== 内存/MMIO 测试 ==========\n";

        // 测试 Timer MMIO
        std::cout << "Timer MMIO (0x02004000):\n";
        uint32_t mtime_lo = bus->read_word(0x02004000);
        uint32_t mtime_hi = bus->read_word(0x02004004);
        uint64_t mtime = (static_cast<uint64_t>(mtime_hi) << 32) | mtime_lo;
        std::cout << "  MTIME = 0x" << std::hex << std::setfill('0') << std::setw(16) << mtime << "\n";

        uint32_t mtimecmp_lo = bus->read_word(0x02004008);
        uint32_t mtimecmp_hi = bus->read_word(0x0200400C);
        uint64_t mtimecmp = (static_cast<uint64_t>(mtimecmp_hi) << 32) | mtimecmp_lo;
        std::cout << "  MTIMECMP = 0x" << std::hex << std::setfill('0') << std::setw(16) << mtimecmp << "\n";

        // 测试 UART MMIO
        std::cout << "\nUART MMIO (0x10000000):\n";
        uint32_t txdata = bus->read_word(0x10000000);
        uint32_t txctrl = bus->read_word(0x10000008);
        uint32_t rxctrl = bus->read_word(0x1000000C);
        std::cout << "  TXDATA = 0x" << std::hex << std::setfill('0') << std::setw(8) << txdata << "\n";
        std::cout << "  TXCTRL = 0x" << std::hex << std::setfill('0') << std::setw(8) << txctrl << "\n";
        std::cout << "  RXCTRL = 0x" << std::hex << std::setfill('0') << std::setw(8) << rxctrl << "\n";

        // 写 UART TXDATA
        std::cout << "\n写入 UART TXDATA = 'X':\n";
        bus->write_word(0x10000000, 'X');

        // 写 UART TXCTRL
        std::cout << "写入 UART TXCTRL = 1 (enable TX):\n";
        bus->write_word(0x10000008, 1);

        // 再次发送
        bus->write_word(0x10000000, 'Y');

        std::cout << "\n====================================\n";
    }

    // 中断测试
    void test_interrupt() {
        std::cout << "\n========== 中断测试 ==========\n";

        // Timer 中断测试
        std::cout << "Timer 中断测试:\n";
        timer->reset();
        std::cout << "  Reset timer\n";
        std::cout << "  Current MTIME: " << timer->get_mtime() << "\n";

        timer->set_mtimecmp(timer->get_mtime() + 100);
        std::cout << "  Set MTIMECMP to mtime + 100\n";
        std::cout << "  check_interrupt(): " << (timer->check_interrupt() ? "Pending" : "Not pending") << "\n";

        std::cout << "\n  Simulating 100 timer ticks...\n";
        for (int i = 0; i < 100; i++) {
            timer->tick();
        }
        std::cout << "  After 100 ticks:\n";
        std::cout << "  MTIME = " << timer->get_mtime() << "\n";
        std::cout << "  check_interrupt(): " << (timer->check_interrupt() ? "INTERRUPT PENDING!" : "Not pending") << "\n";

        timer->clear_interrupt();
        std::cout << "  After clear_interrupt():\n";
        std::cout << "  check_interrupt(): " << (timer->check_interrupt() ? "Pending" : "Not pending") << "\n";

        // UART 中断测试
        std::cout << "\nUART 中断测试:\n";
        uart->reset();
        std::cout << "  Reset UART\n";

        uart->write(0x10, nullptr, 0);  // IE 地址
        uint32_t ie_val = 0x2;  // 启用 RX 中断
        uint8_t data[4] = {ie_val, 0, 0, 0};
        uart->write(0x10, data, 4);
        std::cout << "  Enabled UART RX interrupt (IE = 0x2)\n";

        // 添加数据触发中断
        uart->put_char('A');
        std::cout << "  Put 'A' into RX FIFO\n";
        std::cout << "  check_interrupt(): " << (uart->check_interrupt() ? "INTERRUPT PENDING!" : "Not pending") << "\n";

        std::cout << "\n===============================\n";
    }

    // 运行模拟器 n 步 (用于自动运行模式)
    void run_steps(int steps, bool interactive = false) {
        if (steps < 0) steps = 0;

        std::cout << "\n========== 运行模拟器 ==========\n";
        if (steps == 0) {
            std::cout << "Running until halt...\n\n";
        } else {
            std::cout << "Running " << steps << " steps...\n\n";
        }

        cpu->halt = false;
        running = true;

        if (interactive) {
            start_uart_input();
            std::cout << "按 Ctrl+C 停止程序运行\n\n";
        }

        int count = 0;
        while (!cpu->halt) {
            cpu->step();
            count++;

            if (interactive) {
                process_uart_input();
            }

            if (steps > 0 && count >= steps) {
                break;
            }

            // 每 1000 步打印一次进度
            if (count % 1000 == 0) {
                std::cout << "Progress: " << count << " steps, PC=0x" 
                          << std::hex << std::setfill('0') << std::setw(8) << cpu->pc << "\n";
            }
        }

        if (interactive) {
            stop_uart_input();
        }

        std::cout << "\nRan " << count << " steps.\n";
        std::cout << "PC: 0x" << std::hex << std::setfill('0') << std::setw(8) << cpu->pc << "\n";
        std::cout << "Halt: " << (cpu->halt ? "Yes" : "No") << "\n";
        if (cpu->halt) {
            std::cout << "Exit code: " << std::dec << cpu->exit_code << "\n";
        }

        std::cout << "\n================================\n";
    }

    // 加载新的 ELF
    void load_elf_file() {
        std::cout << "\n========== 加载 ELF ==========\n";
        std::cout << "可用文件:\n";
        std::system("ls -la out/ 2>/dev/null || echo 'out/ 目录不存在'");
        std::cout << "\n输入 ELF 文件路径 (直接回车取消): ";

        std::string path;
        std::getline(std::cin, path);

        // 清理输入
        while (!path.empty() && (path.back() == '\r' || path.back() == '\n')) {
            path.pop_back();
        }

        if (path.empty()) {
            std::cout << "取消加载.\n";
            return;
        }

        std::cout << "Loading: '" << path << "'\n";
        cleanup();
        if (init(path)) {
            std::cout << "Successfully loaded: " << path << "\n";
        } else {
            std::cerr << "Failed to load: " << path << "\n";
            init_bare_metal();
        }

        std::cout << "\n=============================\n";
    }

    // 获取入口点 PC (用于调试)
    uint32_t get_entry_pc() const {
        return cpu ? cpu->pc : 0;
    }

    // 获取退出码
    int get_exit_code() const {
        return cpu ? cpu->exit_code : -1;
    }

    // 获取是否已停止
    bool is_halted() const {
        return cpu ? cpu->halt : true;
    }

    // 获取步骤数
    size_t get_step_count() const {
        return cpu ? cpu->step_count : 0;
    }

    // 显示tests文件夹下的所有文件
    void list_test_files() {
        std::cout << "\n========== 可用测试文件 ==========\n";
        std::system("ls -lh tests/ 2>/dev/null | grep -E '\\.(c|s)$' || echo 'tests/ 目录不存在或无文件'");
        std::cout << "================================\n";
    }

    // 运行程序模式（单步或自动）
    void run_program_mode() {
        std::string elf_file = "";
        bool loaded = false;

        while (true) {
            if (!loaded) {
                std::cout << "\n请选择测试文件（输入文件名，例如: tests/timer_uart_test.c）\n";
                list_test_files();
                std::cout << "输入文件路径（直接回车返回主菜单）: ";

                std::string path;
                std::getline(std::cin, path);

                // 清理输入（去除尾随空白字符）
                while (!path.empty() && (path.back() == '\r' || path.back() == '\n' || path.back() == ' ' || path.back() == '\t')) {
                    path.pop_back();
                }

                if (path.empty()) {
                    return; // 返回主菜单
                }

                // 检查文件是否存在
                std::ifstream file_check(path);
                if (!file_check.good()) {
                    std::cerr << "错误: 文件不存在或无法访问: " << path << "\n";
                    std::cout << "请重新输入。\n";
                    continue;
                }

                // 提示用户编译
                std::cout << "\n请按照 compile.sh 方法编译所需二进制文件:\n";
                std::cout << "  汇编文件 (.s): ./compile.sh asm <file.s>\n";
                std::cout << "  C 文件 (.c):   ./compile.sh c <file.c>\n";
                std::cout << "\n请确保已编译出 ELF 文件后再继续。\n";
                std::cout << "是否已编译? (y/n): ";

                std::string confirm;
                std::getline(std::cin, confirm);
                if (confirm != "y" && confirm != "Y") {
                    std::cout << "请先编译文件，然后重新运行程序。\n";
                    continue;
                }

                // 尝试加载 ELF 文件（假设源文件和 ELF 文件同名但无扩展名或在 out/ 目录）
                std::string elf_path = path;
                // 如果输入的是 tests/ 下的 .c 或 .s 文件，尝试在 out/ 目录找对应的 ELF
                if (elf_path.find("tests/") == 0) {
                    std::string base = elf_path.substr(6); // 去掉 "tests/"
                    size_t dot_pos = base.rfind('.');
                    if (dot_pos != std::string::npos) {
                        base = base.substr(0, dot_pos);
                    }
                    elf_path = "out/" + base;
                }

                std::cout << "尝试加载 ELF: " << elf_path << "\n";
                cleanup();
                if (init(elf_path)) {
                    std::cout << "成功加载: " << elf_path << "\n";
                    loaded = true;
                } else {
                    std::cerr << "无法加载 ELF: " << elf_path << "\n";
                    std::cout << "请确认是否已正确编译。\n";
                }
                continue;
            }

            // 已加载，显示运行选项
            std::cout << "\n请选择运行方式:\n";
            std::cout << "  1. 单步执行（每次输入 n 执行一步）\n";
            std::cout << "  2. 自动运行（输入步数或回车运行至完成）\n";
            std::cout << "  q. 返回主菜单\n";
            std::cout << "选择: ";

            std::string mode_input;
            std::getline(std::cin, mode_input);

            if (mode_input.empty()) continue;

            if (mode_input == "q" || mode_input == "Q") {
                loaded = false;
                continue;
            }

            if (mode_input == "1") {
                // 单步执行模式
                std::cout << "\n=== 单步执行模式 ===\n";
                std::cout << "输入 n 执行下一步，输入 q 返回\n";
                while (true) {
                    std::cout << "\n[单步] 输入 n (next) 或 q (quit): ";
                    std::string step_input;
                    std::getline(std::cin, step_input);

                    if (step_input.empty()) continue;

                    if (step_input == "n" || step_input == "N") {
                        if (cpu->halt) {
                            std::cout << "程序已停��。退���码: " << cpu->exit_code << "\n";
                            break;
                        }
                        cpu->step();
                        std::cout << "PC=0x" << std::hex << std::setfill('0') << std::setw(8) << cpu->pc
                                  << std::dec << "  Steps: " << cpu->step_count << "\n";
                    } else if (step_input == "q" || step_input == "Q") {
                        break;
                    } else {
                        std::cout << "无效输入，请输入 n 或 q\n";
                    }
                }
            } else if (mode_input == "2") {
                // 自动运行模式
                std::cout << "\n=== 自动运行模式 ===\n";
                std::cout << "输入步数（整数）直接回车则运行至程序完成: ";
                std::string steps_input;
                std::getline(std::cin, steps_input);

                if (steps_input.empty()) {
                    // 运行至完成
                    std::cout << "\n运行至程序完成...\n\n";
                    run_steps(0); // 0 表示无限制运行
                } else {
                    // 运行指定步数
                    try {
                        int steps = std::stoi(steps_input);
                        if (steps <= 0) steps = 100;
                        std::cout << "\n运行 " << steps << " 步...\n\n";
                        run_steps(steps);
                    } catch (...) {
                        std::cerr << "无效的步数，运行 100 步...\n\n";
                        run_steps(100);
                    }
                }
            } else {
                std::cout << "无效选择，请重新选择。\n";
            }
        }
    }

    // 增加指令菜单（原有功能的映射）
    void add_instruction_menu() {
        while (true) {
            std::cout << "\n========== 增加指令/测试 ==========\n";
            std::cout << "请参考模板文件 tests/instruction_test.c 设计您的测试程序。\n";
            
    
            std::cout << "编辑完成后，请参考 compile.sh 进行编译：\n";
            std::cout << "  C 程序: ./compile.sh c <your_file.c>\n";
            std::cout << "  汇编程序: ./compile.sh asm <your_file.s>\n";
            std::cout << "  反汇编: ./compile.sh dump <elf_file>\n\n";
    
            std::cout << "按 Enter 键返回主菜单，然后选择 \"1. 运行程序\" 来运行您的程序。\n";

            std::string input;
            std::getline(std::cin, input);

            
        }
    }

    // 建立新的外设测试文件
    void create_new_device_test() {
        std::cout << "\n========== 建立新的外设测试 ==========\n";
        std::cout << "输入新文件名（不含路径，例如: my_device_test.c）: ";
        
        std::string filename;
        std::getline(std::cin, filename);
        
        // 清理输入
        while (!filename.empty() && (filename.back() == '\r' || filename.back() == '\n')) {
            filename.pop_back();
        }
        
        if (filename.empty()) {
            std::cout << "取消创建。\n";
            return;
        }
        
        // 添加 .c 扩展名（如果没有）
        if (filename.find(".c") == std::string::npos) {
            filename += ".c";
        }
        
        std::string filepath = "tests/" + filename;
        
        // 检查文件是否已存在
        std::ifstream file_check(filepath);
        if (file_check.good()) {
            std::cout << "文件已存在: " << filepath << "\n";
            std::cout << "是否覆盖? (y/n): ";
            std::string confirm;
            std::getline(std::cin, confirm);
            if (confirm != "y" && confirm != "Y") {
                std::cout << "取消创建。\n";
                return;
            }
        }
        
        // 复制模板文件
        std::ifstream src("tests/program_test_device.c", std::ios::binary);
        if (!src.is_open()) {
            std::cerr << "无法打开模板文件: tests/program_test_device.c\n";
            return;
        }
        
        std::ofstream dst(filepath, std::ios::binary);
        if (!dst.is_open()) {
            std::cerr << "无法创建文件: " << filepath << "\n";
            return;
        }
        
        dst << src.rdbuf();
        src.close();
        dst.close();
        
        std::cout << "已创建文件: " << filepath << "\n";
        
        // 询问是否打开编辑器
        std::cout << "\n是否打开编辑器编辑该文件? (y/n): ";
        std::string edit_confirm;
        std::getline(std::cin, edit_confirm);
        
        if (edit_confirm == "y" || edit_confirm == "Y") {
            // 使用系统默认编辑器打开文件
            const char* editor = std::getenv("EDITOR");
            if (!editor) editor = "nano";
            
            std::string cmd = std::string(editor) + " " + filepath;
            std::cout << "正在打开编辑器...\n";
            int ret = std::system(cmd.c_str());
            
            if (ret == 0) {
                std::cout << "编辑完成。\n";
                
                // 询问是否编译
                std::cout << "\n是否编译该文件? (y/n): ";
                std::string compile_confirm;
                std::getline(std::cin, compile_confirm);
                
                if (compile_confirm == "y" || compile_confirm == "Y") {
                    compile_c_file(filepath);
                }
            } else {
                std::cout << "编辑器退出失败。\n";
            }
        }
        
        std::cout << "\n====================================\n";
    }

    // 列出并选择要编译的文件
    void list_and_compile_files() {
        std::cout << "\n========== 编译已有代码 ==========\n";
        std::cout << "tests/ 目录下的 .c 文件:\n\n";
        
        // 获取 tests/ 目录下的 .c 文件列表
        std::vector<std::string> c_files;
        DIR* dir = opendir("tests/");
        if (dir) {
            struct dirent* entry;
            while ((entry = readdir(dir)) != nullptr) {
                std::string name = entry->d_name;
                if (name.length() > 2 && name.substr(name.length() - 2) == ".c") {
                    c_files.push_back(name);
                }
            }
            closedir(dir);
        }
        
        if (c_files.empty()) {
            std::cout << "没有找到 .c 文件。\n";
            std::cout << "================================\n";
            return;
        }
        
        // 按字母排序
        std::sort(c_files.begin(), c_files.end());
        
        // 显示文件列表
        for (size_t i = 0; i < c_files.size(); i++) {
            std::cout << "  " << (i + 1) << ". " << c_files[i] << "\n";
        }
        std::cout << "\n  0. 返回\n";
        std::cout << "\n================================\n";
        
        std::cout << "选择要编译的文件（输入编号）: ";
        std::string choice_input;
        std::getline(std::cin, choice_input);
        
        if (choice_input.empty() || choice_input == "0") {
            std::cout << "取消编译。\n";
            return;
        }
        
        // 解析选择
        try {
            int choice = std::stoi(choice_input);
            if (choice < 1 || choice > static_cast<int>(c_files.size())) {
                std::cout << "无效选择。\n";
                return;
            }
            
            std::string selected_file = "tests/" + c_files[choice - 1];
            std::cout << "\n已选择: " << selected_file << "\n";
            
            // 询问编译选项
            std::cout << "\n========== 编译选项 ==========\n";
            std::cout << "  1. 直接编译\n";
            std::cout << "  2. 编译并运行（交互模式）\n";
            std::cout << "  3. 编译并运行（自动模式）\n";
            std::cout << "  q. 返回\n";
            std::cout << "\n选择操作: ";
            
            std::string compile_choice;
            std::getline(std::cin, compile_choice);
            
            if (compile_choice == "q" || compile_choice == "Q") {
                return;
            }
            
            // 执行编译
            if (compile_choice == "1" || compile_choice == "2" || compile_choice == "3") {
                compile_c_file(selected_file);
                
                if (compile_choice == "2" || compile_choice == "3") {
                    // 编译成功后运行
                    // 获取 ELF 文件路径
                    std::string elf_path = selected_file;
                    size_t dot_pos = elf_path.rfind('.');
                    if (dot_pos != std::string::npos) {
                        elf_path = elf_path.substr(0, dot_pos);
                    }
                    elf_path = "out/" + elf_path;
                    
                    // 替换 tests/ 前缀
                    size_t tests_pos = elf_path.find("tests/");
                    if (tests_pos != std::string::npos) {
                        elf_path = elf_path.substr(0, tests_pos) + elf_path.substr(tests_pos + 6);
                    }
                    
                    std::cout << "\n正在加载 ELF: " << elf_path << "\n";
                    cleanup();
                    if (init(elf_path)) {
                        std::cout << "成功加载，准备运行...\n";
                        if (compile_choice == "2") {
                            // 交互模式
                            run_steps(0, true);
                        } else {
                            // 自动模式
                            run_steps(10000, false);
                        }
                    } else {
                        std::cerr << "无法加载 ELF: " << elf_path << "\n";
                    }
                }
            } else {
                std::cout << "无效选择。\n";
            }
            
        } catch (...) {
            std::cout << "无效输入。\n";
        }
        
        std::cout << "\n================================\n";
    }

    // 编译指定的 C 文件
    void compile_c_file(const std::string& filepath) {
        std::cout << "\n========== 编译文件 ==========\n";
        std::cout << "正在编译: " << filepath << "\n\n";
        
        // 调用 compile.sh 进行编译
        std::string cmd = "./compile.sh c " + filepath;
        int ret = std::system(cmd.c_str());
        
        if (ret == 0) {
            std::cout << "\n编译成功！\n";
            
            // 显示生成的 ELF 文件
            std::string elf_path = filepath;
            size_t dot_pos = elf_path.rfind('.');
            if (dot_pos != std::string::npos) {
                elf_path = elf_path.substr(0, dot_pos);
            }
            // 替换 tests/ 为 out/
            size_t tests_pos = elf_path.find("tests/");
            if (tests_pos != std::string::npos) {
                elf_path = elf_path.substr(0, tests_pos) + "out/" + elf_path.substr(tests_pos + 6);
            }
            
            std::cout << "ELF 文件: " << elf_path << "\n";
        } else {
            std::cout << "\n编译失败！退出码: " << ret << "\n";
        }
        
        std::cout << "=============================\n";
    }

    // 增加外设（新版简化流程）
    void add_device() {
        while (true) {
            std::cout << "\n========== 增加外设 ==========\n";
            std::cout << "  1. 建立新的外设测试代码\n";
            std::cout << "  2. 编译已有代码\n";
            std::cout << "  q. 返回主菜单\n";
            std::cout << "================================\n";
            std::cout << "\n选择操作: ";
            
            std::string choice;
            std::getline(std::cin, choice);
            
            if (choice == "1") {
                create_new_device_test();
            } else if (choice == "2") {
                list_and_compile_files();
            } else if (choice == "q" || choice == "Q") {
                std::cout << "返回主菜单。\n";
                return;
            } else {
                std::cout << "无效选择，请重新输入。\n";
            }
        }
    }

    // 主菜单循环
    void menu_loop() {
        std::cout << "\n";
        std::cout << "================================\n";
        std::cout << "  RISC-V 模拟器 - 交互式测试\n";
        std::cout << "================================\n";
        std::cout << "\n欢迎使用!\n\n";

        if (!cpu) {
            std::cout << "初始化裸机测试环境...\n";
            init_bare_metal();
        }

        show_status();

        while (true) {
            print_main_menu();

            std::string input;
            std::getline(std::cin, input);

            if (input.empty()) continue;

            if (input == "1") {
                run_program_mode();
            } else if (input == "2") {
                add_instruction_menu();
            } else if (input == "3") {
                add_device();
            } else if (input == "q" || input == "Q") {
                std::cout << "退出程序.\n";
                return;
            } else {
                std::cout << "未知命令: " << input << "\n";
            }
        }
    }
};

// 导出给 test.cpp 调用的函数
void test_interactive() {
    InteractiveDeviceTest test;
    test.menu_loop();
}

void test_interactive_with_elf(const std::string& elf_file) {
    InteractiveDeviceTest test;
    if (test.init(elf_file)) {
        test.menu_loop();
    } else {
        std::cerr << "Failed to initialize with ELF: " << elf_file << "\n";
    }
}

// 独立运行入口
int main(int argc, char* argv[]) {
    InteractiveDeviceTest test;
    bool auto_run = false;
    bool interactive_mode = false;  // 交互模式：键盘输入传递给 UART
    int run_steps = 10000;
    std::string elf_file;

    // 解析命令行参数
    for (int i = 1; i < argc; i++) {
        std::string arg = argv[i];
        if (arg == "--run" || arg == "-r") {
            auto_run = true;
            // 尝试解析步数
            if (i + 1 < argc) {
                std::string next = argv[i + 1];
                if (!next.empty() && next[0] >= '0' && next[0] <= '9') {
                    try {
                        run_steps = std::stoi(next);
                        i++;  // 跳过已解析的步数
                    } catch (...) {
                        run_steps = 10000;
                    }
                }
            }
        } else if (arg == "--interactive" || arg == "-i") {
            // 交互模式：键盘输入传递给 UART RX
            interactive_mode = true;
            auto_run = true;
            run_steps = 0;  // 运行到结束
        } else if (arg == "--help" || arg == "-h") {
            std::cout << "用法: " << argv[0] << " [OPTIONS] [ELF_FILE]\n";
            std::cout << "选项:\n";
            std::cout << "  --run, -r [N]       加载 ELF 后自动运行 N 步 (默认 10000)\n";
            std::cout << "  --interactive, -i  交互模式: 键盘输入传递给 UART RX\n";
            std::cout << "  --help, -h         显示帮助信息\n";
            std::cout << "\n示例:\n";
            std::cout << "  " << argv[0] << "                           # 交互模式\n";
            std::cout << "  " << argv[0] << " out/timer_uart_test        # 加载后交互\n";
            std::cout << "  " << argv[0] << " --run out/timer_uart_test  # 加载后自动运行\n";
            std::cout << "  " << argv[0] << " -i out/timer_uart_test    # 交互模式运行\n";
            return 0;
        } else {
            // 假设是 ELF 文件
            elf_file = arg;
        }
    }

    // 如果有 ELF 文件，先加载
    if (!elf_file.empty()) {
        std::cout << "加载 ELF 文件: " << elf_file << "\n";
        if (!test.init(elf_file)) {
            std::cerr << "无法加载 ELF: " << elf_file << "\n";
            return 1;
        }
        std::cout << "入口 PC=0x" << std::hex << std::setfill('0') << std::setw(8) << test.get_entry_pc() << "\n";
        
        // 加载了 ELF 就直接运行，不进入交互菜单
        std::cout << "\n========== 运行 " << run_steps << " 步 ==========\n\n";
        test.run_steps(run_steps, interactive_mode);
        std::cout << "\n========== 运行结束 ==========\n";
        test.show_status();
    } else {
        test.menu_loop();
    }

    return 0;
}
