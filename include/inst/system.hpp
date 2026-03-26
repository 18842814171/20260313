// include/inst/ecall.hpp
#ifndef INST_ECALL_HPP
#define INST_ECALL_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     
#include "Decoder.hpp"
#include "Pipe.hpp"
#define DEBUG 1

inline void inst_ebreak(CPU& cpu, Pipe& p) {
    LOG(cpu.get_inst_name(p.inst_id));
    PUSH;

    LOG("EBREAK - Breakpoint");

    // Simplest behavior: stop execution
    cpu.halt = true;

    // Optional: distinguish from normal exit
    cpu.exit_code = -1;

    POP;
}


inline void inst_ecall(CPU& cpu, Pipe& p) {
    LOG(cpu.get_inst_name(p.inst_id));
    PUSH;
    
    // ECALL is used for system calls
    // In a simple emulator, we can handle it as a special case
    // For the program "return 0", we need to set the return value
    // and signal termination
    
    LOG("ECALL - System call");
    
    uint32_t syscall = cpu.reg[17]; // a7
    uint32_t arg0    = cpu.reg[10]; // a0

    switch (syscall) {
        case 93: // exit
            cpu.halt = true;
            cpu.exit_code = arg0;
            LOG("Exit syscall with code: " + std::to_string(arg0));
            break;

        default:
            LOG("Unknown syscall: " + std::to_string(syscall));
            cpu.halt = true;
            break;
    }
    
    POP;
}

#endif