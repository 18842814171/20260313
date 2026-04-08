#include "SimulatorAPI.hpp"
#include "Instmngr.hpp"
#include "CPU.hpp"
#include "Device.hpp"
#include "Bus.hpp"
#include "Timer.hpp"
#include "Decoder.hpp"
#include "Loader.hpp"
#include "Interrupt.hpp"
#include "utils/utils.hpp"
#include "inst/arithm.hpp"
#include "inst/load_store.hpp"
#include "inst/auipc.hpp"
#include "inst/beq.hpp"
#include "inst/jump.hpp"
#include "inst/system.hpp"
#include "inst/lui.hpp"
#include "inst/opcode.hpp"
#include <iostream>
#include <stdexcept>
#include <fstream>
#include <cstdlib>
#include <sys/stat.h>

// Forward declaration - defined in simulator.cpp
extern void simulator(std::string infile, size_t max_steps);

void register_all_instructions(InstManager *im) {
    im->register_inst(INST_ADD, "ADD", inst_add);
    im->register_inst(INST_SUB, "SUB", inst_sub);
    im->register_inst(INST_ADDI, "ADDI", inst_addi);
    im->register_inst(INST_AUIPC, "AUIPC", inst_auipc);
    im->register_inst(INST_LUI, "LUI", inst_lui);
    im->register_inst(INST_LW, "LW", inst_lw);
    im->register_inst(INST_SW, "SW", inst_sw);
    im->register_inst(INST_BEQ, "BEQ", inst_beq);
    im->register_inst(INST_JAL, "JAL", inst_jal);
    im->register_inst(INST_JALR, "JALR", inst_jalr);
    im->register_inst(INST_EBREAK, "EBREAK", inst_ebreak);
    im->register_inst(INST_ECALL, "ECALL", inst_ecall);
    im->register_inst(INST_WFI, "WFI", inst_wfi);
    LOG("Instruction table initialized with " + std::to_string(im->size()) + " entries");
}

void init_cpu(CPU*& cpu, Memory*& mem, InstManager*& im,
               const std::string& infile, size_t max_steps) {
    im = new InstManager();
    register_all_instructions(im);
    
    mem = new Memory();
    cpu = new CPU(*mem, *im);
    
    static InterruptController int_ctrl;
    static TrapHandler trap;
    cpu->set_interrupt_controller(&int_ctrl);
    cpu->set_trap_handler(&trap);
    cpu->enable_interrupts();
    
    uint32_t entry_point = load_elf(infile, *mem);
    uint32_t gp_val = get_symbol(infile, "__global_pointer$");
    
    auto args = setup_args_for_elf(infile, 0x20000, *mem);
    
    cpu->set_pc(entry_point);
    cpu->reg[0] = 0;
    cpu->reg[1] = 0xFFFFFFFF;
    cpu->reg[2] = args.sp;
    cpu->reg[3] = gp_val;
    cpu->reg[4] = 0;
    cpu->reg[10] = args.argc;
    cpu->reg[11] = args.argv_addr;
    cpu->reg[12] = 0;
    cpu->reg[17] = 0;
    
    LOG("CPU initialized for: " + infile);
}

void cleanup_cpu(CPU* cpu, Memory* mem, InstManager* im) {
    delete cpu;
    delete im;
}

// 编译汇编文件为 ELF
// 返回生成的 ELF 文件路径，编译失败则抛出异常
std::string compile_asm_to_elf(const std::string& asm_file) {
    struct stat buffer;
    if (stat(asm_file.c_str(), &buffer) != 0) {
        throw std::runtime_error("File doesn't exist: " + asm_file);
    }

    std::string base_path = asm_file.substr(0, asm_file.find_last_of('/') + 1);
    std::string asm_basename = asm_file.substr(asm_file.find_last_of('/') + 1);
    std::string elf_name = base_path + "out_" + asm_basename;
    if (elf_name.find(".s") == elf_name.length() - 2) {
        elf_name = elf_name.substr(0, elf_name.length() - 2);
    }
    

    std::string as_cmd = "/opt/riscv/bin/riscv64-unknown-elf-as -march=rv32i " + asm_file + " -o " + elf_name;
    int as_result = system(as_cmd.c_str());
    if (as_result != 0) {
        throw std::runtime_error("Assembly failed: " + as_cmd);
    }

    std::string fix_cmd = "/opt/riscv/bin/riscv64-unknown-elf-objcopy -O elf32-littleriscv --set-start 0x10000 " + elf_name;
    system(fix_cmd.c_str());

    return elf_name;
}

void test_simple_asm(const std::string& asm_file) {
    std::cout << "\n========== TEST E0: Simple ASM Program ==========\n";
    LOG("Starting simple ASM test - " + asm_file);

    // 1. 编译汇编文件为 ELF
    std::string elf_file;
    try {
        elf_file = compile_asm_to_elf(asm_file);
        LOG("Compile finished: " + asm_file + " -> " + elf_file);
    } catch (const std::exception& e) {
        LOG("Compile failed: " + std::string(e.what()));
        return;
    }

    // 2. 初始化 CPU 和内存
    InstManager* im = new InstManager();
    register_all_instructions(im);

    Memory* mem = new Memory();
    CPU* cpu = new CPU(*mem, *im);

    static InterruptController int_ctrl;
    static TrapHandler trap;
    cpu->set_interrupt_controller(&int_ctrl);
    cpu->set_trap_handler(&trap);
    cpu->enable_interrupts();

    // 3. 加载 ELF 到内存
    uint32_t entry_point;
    try {
        entry_point = load_elf(elf_file, *mem);
        LOG("ELF entry: 0x" + HEX(entry_point));
    } catch (const std::exception& e) {
        LOG("Failed to load ELF " );
        cleanup_cpu(cpu, mem, im);
        return;
    }

    // 4. 设置 CPU 初始状态
    // 如果入口点是默认的 0x10000（简单的原始代码），跳过 sp 设置让代码自己处理
    // 否则使用标准程序入口，需要设置栈
    if (entry_point == 0x10000) {
        // 简单汇编代码：直接执行，假设 sp 已在代码/链接脚本中设置
        cpu->set_pc(entry_point);
        cpu->reg[0] = 0;           // x0 = 0 (constant zero)
        // 不设置 sp，让汇编代码自己处理或链接脚本设置
        cpu->reg[10] = 0;          // a0 = 0
        cpu->reg[17] = 0;          // a7 = 0
        LOG("Simple asm test: default entry = 0x10000");
    } else {
        // 标准程序入口：需要设置栈
        cpu->set_pc(entry_point);
        cpu->reg[0] = 0;           // x0 = 0 (constant zero)
        cpu->reg[2] = 0x20000;     // sp (stack pointer)
        cpu->reg[10] = 0;          // a0 = 0 (return value)
        cpu->reg[17] = 0;          // a7 = 0 (syscall number)
        LOG("Entry 0x" + HEX(entry_point));
    }

    // 5. 运行程序（最多 10000 条指令）
    
    cpu->run(2000);

    // 6. 输出结果
    
    std::cout << "\nResult: ";
    if (cpu->halt) {
        LOG("PASS - Halted after " + DEC(cpu->step_count) + " steps");
    } else {
        LOG ("FAIL - Did not halt");
    }
    
    LOG("=== Simple ASM Test Complete ===");
    cpu->dump_registers();
    cleanup_cpu(cpu, mem, im);
}

void test_full_program(const std::string& infile) {
    LOG("========== TEST E1: Full Program ==========");
    LOG("Running full program: " + infile);
    
    CPU* cpu = nullptr;
    Memory* mem = nullptr;
    InstManager* im = nullptr;
    Bus* bus = nullptr;
    
    init_cpu(cpu, mem, im, infile, 0);
    
    // 默认挂载所有设备
    bus = new Bus();
    bus->attach_memory(mem);
    static Timer timer;
    bus->attach_device(0x02004000, &timer);
    cpu->attach_bus(bus);
    
    cpu->run(0);
    
    std::cout << "\nResult: ";
    if (cpu->halt) {
        LOG("PASS - Halted after " + DEC(cpu->step_count) + " steps");
    } else {
        LOG ("FAIL - Did not halt");
    }
    
    LOG("\n=== Full Program Test Complete ===");
    cpu->dump_registers();
    cleanup_cpu(cpu, mem, im);
}

void test_interrupt() {
    LOG("========== TEST E2: Interrupt Functionality ==========");
    LOG("Testing interrupt functionality");
    
    InstManager im;
    register_all_instructions(&im);
    
    Memory mem;
    CPU cpu(mem, im);
    
    static InterruptController int_ctrl;
    static TrapHandler trap;
    cpu.set_interrupt_controller(&int_ctrl);
    cpu.set_trap_handler(&trap);
    cpu.enable_interrupts();
    
    
    LOG("\n=== Interrupt Test Complete ===");
    cpu.dump_registers();
}

void test_ext_device(const std::string& infile) {
    LOG("========== TEST E3: External Device ==========");
    LOG("Testing with external device: " + infile);
    
    CPU* cpu = nullptr;
    Memory* mem = nullptr;
    InstManager* im = nullptr;
    
    init_cpu(cpu, mem, im, infile, 0);
    
    // Check if program uses UART or other devices
    LOG("Looking for device access in program...");
    LOG("Memory base: 0x10000, MMIO range: 0x10000000");
    
    // Note: The actual device testing would require instrumenting
    // memory reads/writes to detect device access
    LOG("Device test requires specific ELF with device I/O");
    
    cpu->run(500);  // Run limited steps
    
   LOG("Result after 500 steps: ");
    if (cpu->halt) {
        LOG("Halted");
    } else {
        LOG("Running (step " + DEC(cpu->step_count) + ")");
    }
    
    LOG("\n=== External Device Test Complete ===");
    cpu->dump_registers();
    cleanup_cpu(cpu, mem, im);
}

void test_timer_interrupt(const std::string& infile, bool compile) {
    std::cout << "\n========== TEST E2: Timer Interrupt ==========\n";
    LOG("Starting timer interrupt test - " + infile);

    std::string elf_file = infile;
    if (compile) {
        try {
            elf_file = compile_asm_to_elf(infile);
            LOG("Compile finished: " + infile + " -> " + elf_file);
        } catch (const std::exception& e) {
            LOG("Compile failed: " + std::string(e.what()));
            return;
        }
    }

    InstManager* im = new InstManager();
    register_all_instructions(im);

    Memory* mem = new Memory();
    Bus* bus = new Bus();
    bus->attach_memory(mem);

    static Timer timer;
    bus->attach_device(0x02004000, &timer);

    CPU* cpu = new CPU(*mem, *im);
    cpu->attach_bus(bus);

    static InterruptController int_ctrl;
    static TrapHandler trap;
    cpu->set_interrupt_controller(&int_ctrl);
    cpu->set_trap_handler(&trap);
    cpu->enable_interrupts();

    uint32_t entry_point;
    try {
        entry_point = load_elf(elf_file, *mem);
        LOG("ELF entry: 0x" + HEX(entry_point));
    } catch (const std::exception& e) {
        LOG("Failed to load ELF: " + std::string(e.what()));
        cleanup_cpu(cpu, mem, im);
        return;
    }

    cpu->set_pc(entry_point);
    cpu->reg[0] = 0;
    cpu->reg[2] = 0x20000;
    cpu->reg[10] = 0;
    cpu->reg[17] = 0;

    LOG("Starting timer interrupt test...");
    cpu->run(200);

    std::cout << "\nResult: ";
    if (cpu->halt) {
        LOG("PASS - Halted after " + DEC(cpu->step_count) + " steps");
    } else {
        LOG("Running (step " + DEC(cpu->step_count) + ")");
    }

    LOG("\n=== Timer Interrupt Test Complete ===");
    cpu->dump_registers();
    cleanup_cpu(cpu, mem, im);
}
