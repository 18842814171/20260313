//simulator.cpp
#include "utils/utils.hpp"
#include "Instmngr.hpp"
#include "CPU.hpp"
#include "Device.hpp"
#include "Decoder.hpp"
#include "Loader.hpp"
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
std::tuple<std::string, std::string> parseArgs(int argc, char **argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0]
                  << " <infile> [outfile]\n";
        std::exit(1);
    }

    std::string input_filename = argv[1];
    std::string output_filename = "";  // default empty

    if (argc >= 3) {
        output_filename = argv[2];
    }

    return std::make_tuple(input_filename, output_filename);
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

void execute(CPU& cpu, Pipe& p, InstManager *im) {
    im->execute_inst(cpu,p);
}

void simulator(std::string infile, std::string outfile){
    InstManager im;
    register_all_instructions(&im);
    
    // Create CPU and Memory
    Memory mem;
    CPU cpu(mem,im);
        // Load ELF file
    uint32_t entry_point = load_elf(infile, mem);
    
    uint32_t main_addr = get_symbol(infile, "main");
    uint32_t gp_val  = get_symbol(infile, "__global_pointer$");

    if (main_addr == 0) {
        throw std::runtime_error("Could not find 'main' symbol!");
    }
    LOG("Program entry point: 0x"+HEX(entry_point));
    LOG("Jumping to main entry: 0x"+HEX(main_addr));
    if (gp_val) LOG("GP initialized to 0x" + HEX(gp_val));
    // Set program counter to entry point
    cpu.set_pc(main_addr);  // jump straight to main
    cpu.reg[2]=0x20000;
    cpu.reg[3] = gp_val;  // gp (Global Pointer) - will be 0 if not found

    // Run the program (execute instructions)
    cpu.run(30);  
    // Dump registers after execution
    LOG("\n=== Final Register State ===");
    cpu.dump_registers();
    
    // Optionally save output to file
    if (!outfile.empty()) {
        std::ofstream output_file(outfile);
        // Write results to file
        output_file << "Entry point: 0x" << std::hex << entry_point << std::endl;
        output_file.close();
    }
    
   
}

int main(int argc, char *argv[]) {      
    std::string infile, outfile;
    std::tie(infile, outfile) = parseArgs(argc, argv);
    simulator(infile, outfile);
    return 0;
}