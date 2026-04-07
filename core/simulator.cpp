//simulator.cpp
#include "utils/utils.hpp"
#include "Instmngr.hpp"
#include "CPU.hpp"
#include "Device.hpp"
#include "Decoder.hpp"
#include "Loader.hpp"
#include "Interrupt.hpp"
// Include all instruction logic here
#include "inst/arithm.hpp"
#include "inst/load_store.hpp"
#include "inst/auipc.hpp"
#include "inst/beq.hpp"
#include "inst/jump.hpp"
#include "inst/system.hpp"
#include "inst/lui.hpp"

#include "inst/opcode.hpp" // For INST_ADD, etc.
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <string>
#include <tuple>

// Returns: infile, max_steps
static std::tuple<std::string, size_t> parseArgs(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0]
                  << " <infile> [max_steps]\n"
                  << "  max_steps: optional; default 0 (unlimited, until halt).\n";
        std::exit(1);
    }

    std::string input_filename = argv[1];
    size_t max_steps = 0;

    if (argc >= 3) {
        try {
            size_t pos = 0;
            unsigned long long v = std::stoull(argv[2], &pos, 10);
            if (pos == 0 || argv[2][pos] != '\0')
                throw std::invalid_argument("trailing junk");
            max_steps = static_cast<size_t>(v);
        } catch (const std::exception&) {
            std::cerr << "Invalid max_steps: \"" << argv[2] << "\" (need a non-negative integer)\n";
            std::exit(1);
        }
    }

    return std::make_tuple(input_filename, max_steps);
}

void register_all_instructions(InstManager *im) {
    // Now inst_add is in scope because of the include above!
    im->register_inst(INST_ADD, "ADD", inst_add);
    im->register_inst(INST_SUB, "SUB", inst_sub);
    im->register_inst(INST_ADDI, "ADDI", inst_addi);

    // U-type
    im->register_inst(INST_AUIPC, "AUIPC", inst_auipc);
    im->register_inst(INST_LUI,   "LUI",   inst_lui);     // implement similarly to auipc but without PC

    // Load & Store
    im->register_inst(INST_LW,   "LW",   inst_lw);
    im->register_inst(INST_SW,   "SW",   inst_sw);

    im->register_inst(INST_BEQ,   "BEQ",   inst_beq);
    im->register_inst(INST_JAL,  "JAL",  inst_jal);
    im->register_inst(INST_JALR, "JALR", inst_jalr);
    // System
    im->register_inst(INST_EBREAK, "EBREAK", inst_ebreak);
    im->register_inst(INST_ECALL, "ECALL", inst_ecall);
    //im->register_inst(INST_ECALL, "ECALL", inst_ecall);
    LOG("Instruction table initialized with " + std::to_string(im->size()) + " entries");
}

void execute(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out, InstManager *im) {
    im->execute_inst(cpu,in,out);
}

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

    // Run the program (execute instructions)
    cpu.run(max_steps);  
    // Dump registers after execution
    LOG("\n=== Final Register State ===");
    cpu.dump_registers();
    
    // Output exit information
    LOG("Exit code: " + std::to_string(cpu.exit_code));
}

int main(int argc, char* argv[]) {
    std::string infile;
    size_t max_steps = 0;
    std::tie(infile, max_steps) = parseArgs(argc, argv);
    simulator(infile, max_steps);
    return 0;
}