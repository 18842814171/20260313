#include "utils/utils.hpp"
#include "CPU.hpp"
#include "Pipe.hpp"
#include "ALU.hpp"
#define DEBUG 1

// All branch logic is now handled directly in CPU::execute().
// These functions are no-op pass-throughs kept only so that
// inst_manager.execute_inst() still has a valid function pointer.

inline void inst_beq(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)cpu; (void)in; (void)out;
}

inline void inst_blt(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)cpu; (void)in; (void)out;
}

inline void inst_bne(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)cpu; (void)in; (void)out;
}

inline void inst_bge(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)cpu; (void)in; (void)out;
}

inline void inst_bltu(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)cpu; (void)in; (void)out;
}

inline void inst_bgeu(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)cpu; (void)in; (void)out;
}
