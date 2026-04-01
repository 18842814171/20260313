// include/inst/ecall.hpp
#ifndef INST_ECALL_HPP
#define INST_ECALL_HPP
#include "utils/utils.hpp"
#include "CPU.hpp"     

#include "Pipe.hpp"
#define DEBUG 1
inline void inst_ebreak(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    cpu.halt = true;
    cpu.exit_code = -1;
    LOG("EBREAK: Halting");
}

inline void inst_ecall(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    uint32_t syscall = cpu.reg[17]; // a7
    uint32_t arg0    = cpu.reg[10]; // a0

    switch (syscall) {
        case 93: // exit
            cpu.halt = true;
            cpu.exit_code = arg0;
            LOG("ECALL: Exit code " + std::to_string(arg0));
            break;
        default:
            LOG("ECALL: Unknown syscall " + std::to_string(syscall));
            cpu.halt = true;
            break;
    }
}

#endif