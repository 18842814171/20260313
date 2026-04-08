#ifndef SIMULATOR_API_HPP
#define SIMULATOR_API_HPP

#include <string>
#include <cstdint>

class CPU;
class Memory;
class InstManager;
class Bus;

// Register all instructions (defined in simulator.cpp)
void register_all_instructions(InstManager *im);

// Initialize CPU with given ELF file and max steps
void init_cpu(CPU*& cpu, Memory*& mem, InstManager*& im,
               const std::string& infile, size_t max_steps = 0);

// Clean up resources
void cleanup_cpu(CPU* cpu, Memory* mem, InstManager* im);

// Run simple assembly program (direct exit)
void test_simple_asm(const std::string& asm_file);

// Run compiled full program (devices attached by default)
void test_full_program(const std::string& infile);

// Test interrupt functionality
void test_interrupt();

// Test timer interrupt
void test_timer_interrupt(const std::string& elf_file, bool compile = true);

// Test with external device
void test_ext_device(const std::string& infile);

#endif // SIMULATOR_API_HPP
