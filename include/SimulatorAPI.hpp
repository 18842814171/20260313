#ifndef SIMULATOR_API_HPP
#define SIMULATOR_API_HPP

#include <string>
#include <cstdint>

class CPU;
class Memory;
class InstManager;
class Bus;
class UART;
// Register all instructions (defined in simulator.cpp)
void register_all_instructions(InstManager *im);

// Initialize CPU with given ELF file and max steps
void init_cpu(CPU*& cpu, Memory*& mem, InstManager*& im,
               const std::string& infile, size_t max_steps = 0);

// Clean up resources
void cleanup_cpu(CPU* cpu, Memory* mem, InstManager* im);

// Run simple assembly program (expects ELF file)
void test_simple_asm(const std::string& elf_file);

// Run compiled full program（等价于 simulator(infile, 0)）
void test_full_program(const std::string& infile);

// Test timer interrupt (expects ELF file)
//void test_timer_interrupt(const std::string& elf_file);

#endif // SIMULATOR_API_HPP
