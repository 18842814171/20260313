/**
 * @file test_interactive.cpp
 * @brief 交互式设备测试程序
 *
 * 提供交互式界面来测试 Timer 和 UART 设备。
 * 用户可以通过命令行菜单与模拟器中的设备直接交互。
 */

#include "SimulatorAPI.hpp"
#include "device/Timer.hpp"
#include "device/UART.hpp"
#include "device/Bus.hpp"
#include "CPU.hpp"
#include "Instmngr.hpp"
#include "Loader.hpp"
#include "utils/utils.hpp"
#include <iostream>
#include <iomanip>
#include <sstream>
#include <string>
#include <thread>
#include <chrono>
#include <atomic>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>

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
        input_thread_running = true;
        uart_input_thread = std::thread(&InteractiveDeviceTest::uart_input_loop, this);
    }

    // 停止 UART 输入监听
    void stop_uart_input() {
        input_thread_running = false;
        if (uart_input_thread.joinable()) {
            uart_input_thread.join();
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

    // 打印帮助信息
    void print_help() {
        std::cout << "\n";
        std::cout << "========== 交互式设备测试 ==========\n";
        std::cout << "  1. 运行模拟器 (n steps)    - 运行 n 步模拟\n";
        std::cout << "  2. 显示状态               - 显示 CPU 和设备状态\n";
        std::cout << "  3. Timer 测试             - 测试 Timer 设备\n";
        std::cout << "  4. UART 测试              - 测试 UART 设备\n";
        std::cout << "  5. 发送字符到 UART        - 向 UART 发送字符\n";
        std::cout << "  6. 读取键盘输入           - 从键盘读取输入到 UART RX FIFO\n";
        std::cout << "  7. 内存测试               - 测试 MMIO 读写\n";
        std::cout << "  8. 中断测试               - 测试中断功能\n";
        std::cout << "  9. 加载 ELF               - 加载新的 ELF 文件\n";
        std::cout << "  0. 帮助                   - 显示帮助信息\n";
        std::cout << "  q. 退出                   - 退出程序\n";
        std::cout << "====================================\n";
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
    void run_steps(int steps) {
        if (steps <= 0) steps = 100;

        std::cout << "\n========== 运行模拟器 ==========\n";
        std::cout << "Running " << steps << " steps...\n\n";

        cpu->halt = false;
        running = true;

        int count = 0;
        while (!cpu->halt && count < steps) {
            cpu->step();
            count++;

            // 每 1000 步打印一次进度
            if (count % 1000 == 0) {
                std::cout << "Progress: " << count << " steps, PC=0x" 
                          << std::hex << std::setfill('0') << std::setw(8) << cpu->pc << "\n";
            }
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

    // 主菜单循环
    void menu_loop() {
        std::cout << "\n";
        std::cout << "**********************************\n";
        std::cout << "*  RISC-V 模拟器 - 交互式测试    *\n";
        std::cout << "**********************************\n";
        std::cout << "\n";
        std::cout << "欢迎使用交互式设备测试程序!\n";
        std::cout << "此程序允许您直接测试 Timer 和 UART 设备。\n";
        std::cout << "\n";

        if (!cpu) {
            std::cout << "初始化裸机测试环境...\n";
            init_bare_metal();
        }

        show_status();

        while (true) {
            print_help();

            std::string input;
            std::getline(std::cin, input);

            if (input.empty()) continue;

            char cmd = input[0];

            switch (cmd) {
                case '1': {
                    // 运行模拟器
                    int steps = 100;
                    std::istringstream iss(input.substr(1));
                    iss >> steps;
                    if (steps <= 0) steps = 100;
                    run_steps(steps);
                    break;
                }
                case '2':
                    show_status();
                    break;
                case '3':
                    test_timer();
                    break;
                case '4':
                    test_uart();
                    break;
                case '5':
                    send_char_to_uart();
                    break;
                case '6':
                    read_keyboard_to_uart();
                    break;
                case '7':
                    test_memory();
                    break;
                case '8':
                    test_interrupt();
                    break;
                case '9':
                    load_elf_file();
                    break;
                case '0':
                case 'h':
                case 'H':
                case '?':
                    print_help();
                    break;
                case 'q':
                case 'Q':
                    std::cout << "退出程序.\n";
                    return;
                default:
                    std::cout << "未知命令: " << cmd << "\n";
                    print_help();
                    break;
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
                if (next[0] >= '0' && next[0] <= '9') {
                    try {
                        run_steps = std::stoi(next);
                        i++;  // 跳过已解析的步数
                    } catch (...) {
                        run_steps = 10000;
                    }
                }
            }
        } else if (arg == "--help" || arg == "-h") {
            std::cout << "用法: " << argv[0] << " [OPTIONS] [ELF_FILE]\n";
            std::cout << "选项:\n";
            std::cout << "  --run, -r [N]    加载 ELF 后自动运行 N 步 (默认 10000)\n";
            std::cout << "  --help, -h      显示帮助信息\n";
            std::cout << "\n示例:\n";
            std::cout << "  " << argv[0] << "                           # 交互模式\n";
            std::cout << "  " << argv[0] << " out/timer_uart_test        # 加载后交互\n";
            std::cout << "  " << argv[0] << " --run out/timer_uart_test  # 加载后自动运行\n";
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
        std::cout << "ELF 加载成功，入口点 PC=0x" << std::hex << std::setfill('0') << std::setw(8) << test.get_entry_pc() << "\n";
    }

    if (auto_run) {
        std::cout << "\n========== 自动运行模式 ==========\n";
        std::cout << "运行 " << run_steps << " 步...\n\n";
        test.run_steps(run_steps);
        std::cout << "\n========== 运行结束 ==========\n";
        test.show_status();
    } else {
        test.menu_loop();
    }

    return 0;
}
