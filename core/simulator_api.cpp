#include "SimulatorAPI.hpp"
#include "Instmngr.hpp"
#include "CPU.hpp"
#include "device/Device.hpp"
#include "device/Bus.hpp"
#include "device/Timer.hpp"
#include "device/UART.hpp"
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
    // CSR instructions
    im->register_inst(INST_CSRRW, "CSRRW", inst_csrrw);
    im->register_inst(INST_CSRRS, "CSRRS", inst_csrrs);
    im->register_inst(INST_CSRRC, "CSRRC", inst_csrrc);
    im->register_inst(INST_CSRRWI, "CSRRWI", inst_csrrwi);
    im->register_inst(INST_CSRRSI, "CSRRSI", inst_csrrsi);
    im->register_inst(INST_CSRRCI, "CSRRCI", inst_csrrmi);
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

void test_simple_asm(const std::string& elf_file) {
    std::cout << "\n========== TEST E0: Simple ASM Program ==========\n";
    LOG("Loading ELF: " + elf_file);

    // 初始化 CPU 和内存
    InstManager* im = new InstManager();
    register_all_instructions(im);

    Memory* mem = new Memory();
    CPU* cpu = new CPU(*mem, *im);

    static InterruptController int_ctrl;
    static TrapHandler trap;
    cpu->set_interrupt_controller(&int_ctrl);
    cpu->set_trap_handler(&trap);
    cpu->enable_interrupts();

    // 加载 ELF 到内存
    uint32_t entry_point;
    try {
        entry_point = load_elf(elf_file, *mem);
        LOG("ELF entry: 0x" + HEX(entry_point));
    } catch (const std::exception& e) {
        LOG("Failed to load ELF");
        cleanup_cpu(cpu, mem, im);
        return;
    }

    // 设置 CPU 初始状态
    if (entry_point == 0x10000) {
        cpu->set_pc(entry_point);
        cpu->reg[0] = 0;
        cpu->reg[10] = 0;
        cpu->reg[17] = 0;
        LOG("Simple asm test: default entry = 0x10000");
    } else {
        cpu->set_pc(entry_point);
        cpu->reg[0] = 0;
        cpu->reg[2] = 0x20000;
        cpu->reg[10] = 0;
        cpu->reg[17] = 0;
        LOG("Entry 0x" + HEX(entry_point));
    }

    cpu->run(2000);

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
    
    // 默认只挂载 Timer 和内存
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

// test_ext_device: 根据设备类型挂载指定设备
// device_type: "timer", "uart", "all"
void test_ext_device(const std::string& infile, const std::string& device_type) {
    LOG("========== TEST E2: External Device ==========");
    LOG("Testing with device: " + device_type);
    LOG("ELF file: " + infile);
    
    CPU* cpu = nullptr;
    Memory* mem = nullptr;
    InstManager* im = nullptr;
    Bus* bus = nullptr;
    
    init_cpu(cpu, mem, im, infile, 0);
    
    bus = new Bus();
    bus->attach_memory(mem);
    
    // 根据设备类型挂载
    if (device_type == "timer" || device_type == "all") {
        static Timer timer;
        bus->attach_device(0x02004000, &timer);
        LOG("Timer device attached at 0x02004000");
    }
    
    if (device_type == "uart" || device_type == "all") {
        static UART uart;
        bus->attach_device(0x10000000, &uart);
        LOG("UART device attached at 0x10000000");
    }
    
    cpu->attach_bus(bus);
    
    LOG("MMIO range: 0x10000000+");
    
    cpu->run(1000);  // Run limited steps
    
    LOG("Result after 1000 steps: ");
    if (cpu->halt) {
        LOG("Halted with exit_code=" + DEC(cpu->exit_code));
    } else {
        LOG("Running (step " + DEC(cpu->step_count) + ")");
    }
    
    LOG("\n=== External Device Test Complete ===");
    cpu->dump_registers();
    cleanup_cpu(cpu, mem, im);
}

void test_timer_interrupt(const std::string& elf_file) {
    std::cout << "\n========== TEST: Timer Interrupt ==========\n";
    LOG("Starting timer interrupt test - " + elf_file);

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
