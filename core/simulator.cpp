//simulator.cpp
#include "simulator.hpp"
#include "utils/utils.hpp"
#include "Instmngr.hpp"
#include "CPU.hpp"
#include "device/Device.hpp"
#include "device/Bus.hpp"
#include "device/Timer.hpp"
#include "device/UART.hpp"
#include "Decoder.hpp"
#include "Loader.hpp"
#include "Interrupt.hpp"
#include "SimulatorAPI.hpp"
// Include all instruction logic here
#include "inst/arithm.hpp"
#include "inst/load_store.hpp"
#include "inst/auipc.hpp"
#include "inst/branch.hpp"
#include "inst/jump.hpp"
#include "inst/system.hpp"
#include "inst/lui.hpp"

#include "inst/opcode.hpp" // For INST_ADD, etc.
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <string>
#include <tuple>
#include <thread>
#include <chrono>
#include <atomic>
#include <termios.h>
#include <unistd.h>
#include <deque>
#include <mutex>
#define DEBUG 1
// Forward declaration - defined in simulator_api.cpp
extern void register_all_instructions(InstManager *im);

//void execute(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out, InstManager *im) {
   // im->execute_inst(cpu,in,out);
//}

// ============================================================
class StepInputHandler {
private:
    UART* uart;
    std::deque<char> command_queue;      // For 'n', 'c', 'q' commands
    std::deque<uint8_t> uart_buffer;    // For pending characters to send to UART
    std::mutex queue_mutex;
    std::thread input_thread;
    std::atomic<bool> running;
    int stdin_fd;

    StepInputHandler(const StepInputHandler&) = delete;
    StepInputHandler& operator=(const StepInputHandler&) = delete;

    void set_raw_mode() {
        struct termios ttystate;
        tcgetattr(stdin_fd, &ttystate);
        ttystate.c_lflag &= ~(ICANON | ECHO);  // Disable canonical and echo
        ttystate.c_cc[VMIN] = 0;
        ttystate.c_cc[VTIME] = 0;
        tcsetattr(stdin_fd, TCSANOW, &ttystate);
    }

    void restore_terminal() {
        struct termios ttystate;
        tcgetattr(stdin_fd, &ttystate);
        ttystate.c_lflag |= ICANON | ECHO;
        tcsetattr(stdin_fd, TCSANOW, &ttystate);
    }

    void input_loop() {
        set_raw_mode();
        while (running) {
            char c;
            int n = read(stdin_fd, &c, 1);
            if (n > 0) {
                std::lock_guard<std::mutex> lock(queue_mutex);
                if (c == 'n' || c == 'N' || c == 'c' || c == 'C' || c == 'q' || c == 'Q') {
                    command_queue.push_back(c);
                } else if (uart) {
                    if (c == 3) {
                        running = false;
                        break;
                    }
                    if (c == '\n' || c == '\r') {
                        uart_buffer.push_back('\n');
                    } else {
                        uart_buffer.push_back(static_cast<uint8_t>(c));
                    }
                }
            }
            std::this_thread::sleep_for(std::chrono::milliseconds(10));
        }
        restore_terminal();
    }

public:
    StepInputHandler(UART* u = nullptr) : uart(u), running(false), stdin_fd(STDIN_FILENO) {}

    ~StepInputHandler() {
        stop();
    }

    void start() {
        if (!running) {
            running = true;
            input_thread = std::thread(&StepInputHandler::input_loop, this);
        }
    }

    void stop() {
        running = false;
        if (input_thread.joinable()) {
            input_thread.join();
        }
    }

    bool has_command() {
        std::lock_guard<std::mutex> lock(queue_mutex);
        return !command_queue.empty();
    }

    char get_command() {
        std::lock_guard<std::mutex> lock(queue_mutex);
        if (!command_queue.empty()) {
            char c = command_queue.front();
            command_queue.pop_front();
            return c;
        }
        return 0;
    }

    void drain_commands() {
        std::lock_guard<std::mutex> lock(queue_mutex);
        command_queue.clear();
    }

    void pump_uart_input() {
        if (!uart) return;
        std::lock_guard<std::mutex> lock(queue_mutex);
        while (!uart_buffer.empty()) {
            uint8_t c = uart_buffer.front();
            uart_buffer.pop_front();
            uart->put_char(c);
        }
    }
};

// Simulator API functions
void simulator(std::string infile, size_t max_steps) {
    InstManager im;
    register_all_instructions(&im);

    // Create CPU and Memory
    Memory mem;
    CPU cpu(mem,im);

    // Initialize interrupt controller and trap handler
    static InterruptController int_ctrl;
    static TrapHandler trap;
    cpu.set_interrupt_controller(&int_ctrl);
    cpu.set_trap_handler(&trap);
    cpu.enable_interrupts();

    // Load ELF file
    uint32_t entry_point = load_elf(infile, mem);
    uint32_t main_addr = get_symbol(infile, "main");
    uint32_t gp_val = get_symbol(infile, "__global_pointer$");

    LOG("Program entry point: 0x"+HEX(entry_point));
    LOG("Main address: 0x"+HEX(main_addr));
    if (gp_val) LOG("GP initialized to 0x" + HEX(gp_val));

    // Set up stack with argc/argv for _start
    auto args = setup_args_for_elf(infile, 0x20000, mem);

    // Set initial state for proper C runtime initialization
    cpu.set_pc(entry_point);        // Start from _start, not main
    cpu.reg[0] = 0;                 // x0 is always zero
    cpu.reg[1] = 0xFFFFFFFF;       // ra = sentinel (will be overwritten)
    cpu.reg[2] = args.sp;           // sp (stack pointer)
    cpu.reg[3] = gp_val;           // gp (Global Pointer)
    cpu.reg[4] = 0;                // tp (thread pointer)
    // _start expects: a0=argc, a1=argv (pointer to argc on stack)
    cpu.reg[10] = args.argc;       // a0 = argc
    cpu.reg[11] = args.argv_addr;  // a1 = argv (points to argc on stack)
    cpu.reg[12] = 0;               // a2
    cpu.reg[17] = 0;               // a7 (for potential ecalls)

    // Attach Bus (devices are attached by test functions as needed)
    Bus bus;
    bus.attach_memory(&mem);
    cpu.attach_bus(&bus);

    // Run the program (execute instructions)
    cpu.run(max_steps);
    // Dump registers after execution
    LOG("\n=== Final Register State ===");
    cpu.dump_registers();

    // Output exit information
    LOG("Exit code: " + std::to_string(cpu.exit_code));
}

void simulator_interactive(std::string infile, bool enable_uart_input, bool auto_run) {
    InstManager im;
    register_all_instructions(&im);

    // Create CPU and Memory
    Memory mem;
    CPU cpu(mem, im);

    // Initialize interrupt controller and trap handler
    static InterruptController int_ctrl;
    static TrapHandler trap;
    cpu.set_interrupt_controller(&int_ctrl);
    cpu.set_trap_handler(&trap);
    cpu.enable_interrupts();

    // Load ELF file
    uint32_t entry_point = load_elf(infile, mem);
    uint32_t gp_val = get_symbol(infile, "__global_pointer$");

    LOG("Loading ELF: " + infile);
    LOG("Entry point: 0x" + HEX(entry_point));

    // Set up stack
    auto args = setup_args_for_elf(infile, 0x20000, mem);

    cpu.set_pc(entry_point);
    cpu.reg[0] = 0;
    cpu.reg[1] = 0xFFFFFFFF;
    cpu.reg[2] = args.sp;
    cpu.reg[3] = gp_val;
    cpu.reg[4] = 0;
    cpu.reg[10] = args.argc;
    cpu.reg[11] = args.argv_addr;
    cpu.reg[12] = 0;
    cpu.reg[17] = 0;

    // Attach Bus
    Bus bus;
    bus.attach_memory(&mem);

    // Attach devices
    Timer timer;
    bus.attach_device(0x02004000, &timer);

    UART uart;
    bus.attach_device(0x10000000, &uart);

    cpu.attach_bus(&bus);
    cpu.attach_uart(&uart);  // For read(0) syscall

    // Create unified input handler (commands + UART input)
    StepInputHandler input_handler(enable_uart_input ? &uart : nullptr);
    input_handler.start();

    bool continuous_mode = auto_run;  // true = auto run, false = step mode
    bool step_mode = !auto_run;

    if (step_mode) {
        std::cout << "\n========================================\n";
        std::cout << "  Step-by-Step Mode\n";
        std::cout << "  'n' - Step one instruction\n";
        std::cout << "  'c' - Switch to continuous mode\n";
        std::cout << "  'q' - Quit\n";
        std::cout << "========================================\n";
    } else if (enable_uart_input) {
        std::cout << "\n[UART input enabled - type characters to interact]\n";
    }

    // Run the CPU
    cpu.halt = false;
    size_t step_count = 0;
    LOG("\n========== Running (halt when program exits) ==========");

    while (!cpu.halt) {
        // Pump UART input in every iteration
        if (enable_uart_input) {
            input_handler.pump_uart_input();
        }

        // Check for control commands
        while (input_handler.has_command()) {
            char cmd = input_handler.get_command();
            if (cmd == 'q' || cmd == 'Q') {
                std::cout << "\nUser requested quit.\n";
                cpu.halt = true;
                break;
            } else if (cmd == 'c' || cmd == 'C') {
                continuous_mode = true;
                step_mode = false;
                std::cout << "\n[Switched to continuous mode]\n";
            }
        }

        if (cpu.halt) break;

        // Single-step mode: wait for 'n' command
        if (step_mode) {
            std::cout << "\n[s" << step_count << "] PC=0x" << std::hex << cpu.pc << std::dec;
            std::cout << " > " << std::flush;

            bool got_step = false;
            while (!got_step && !cpu.halt) {
                if (input_handler.has_command()) {
                    char cmd = input_handler.get_command();
                    if (cmd == 'n' || cmd == 'N') {
                        got_step = true;
                    } else if (cmd == 'c' || cmd == 'C') {
                        continuous_mode = true;
                        step_mode = false;
                        std::cout << "\n[Switched to continuous mode]\n";
                        got_step = true;
                    } else if (cmd == 'q' || cmd == 'Q') {
                        cpu.halt = true;
                        break;
                    }
                }
                std::this_thread::sleep_for(std::chrono::milliseconds(50));
            }

            if (cpu.halt) break;
        }
        GAP;
        LOG("Step: " + DEC(step_count));
        GAP;
        // Execute one instruction
        cpu.step();
        step_count++;

        // Drain pending commands after each step (fix: commands buffered before prompt)
        if (step_mode) {
            input_handler.drain_commands();
        }

        // Dump registers after each step (in step mode)
        if (step_mode) {
            cpu.dump_registers();
        }

        // Progress report every 1000 steps (in continuous mode)
        if (continuous_mode && step_count % 1000 == 0) {
            LOG("Progress: " + std::to_string(step_count) + " steps, PC=0x" + HEX(cpu.pc));
        }
        if(step_count >= 8000) {
            cpu.halt = true;
        }
    }

    input_handler.stop();

    LOG("\nRan " + std::to_string(step_count) + " steps.");
    LOG("PC: 0x" + HEX(cpu.pc));
    LOG("Halt: " + std::string(cpu.halt ? "Yes" : "No"));
    LOG("Exit code: " + std::to_string(cpu.exit_code));

    LOG("\n========== Final Status ==========");
    LOG("Timer MTIME: " + std::to_string(timer.get_mtime()));
    LOG("UART RX FIFO: " + std::to_string(uart.rx_count()) + " char(s)");
}