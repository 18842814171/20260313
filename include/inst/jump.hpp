// inst/jump.hpp

#ifndef INST_JUMP_HPP
#define INST_JUMP_HPP

#include "CPU.hpp"
#include "Pipe.hpp"
#include "ALU.hpp"

// All jump logic is now handled directly in CPU::execute().
// These functions are no-op pass-throughs kept only so that
// inst_manager.execute_inst() still has a valid function pointer.

inline void inst_jal(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)cpu; (void)in; (void)out;
}

inline void inst_jalr(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)cpu; (void)in; (void)out;
}

#endif
