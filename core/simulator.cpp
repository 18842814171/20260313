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
#include "inst/ecall.hpp"
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
    // System
    im->register_inst(INST_ECALL, "ECALL", inst_ecall);
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
    LOG("Program entry point: 0x"+HEX(entry_point));
    
    // Set program counter to entry point
    cpu.set_pc(entry_point);
    
    // Run the program (execute instructions)
    cpu.run(10);  // Run up to 1000 steps or until program ends
    
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