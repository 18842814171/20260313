//simulator.cpp
#include "simulator.hpp"
#include "utils/utils.hpp"
#include "Instmngr.hpp"
#include "CPU.hpp"
#include "Device.hpp"
#include "Decoder.hpp"
#include "Loader.hpp"
#include "Interrupt.hpp"
#include "SimulatorAPI.hpp"
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

// Forward declaration - defined in simulator_api.cpp
extern void register_all_instructions(InstManager *im);

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