#include "utils/utils.hpp"
#include "CPU.hpp"     

#include "Pipe.hpp"
#include "ALU.hpp"
#define DEBUG 1
// === B-type: BEQ (opcode 0x63, funct3=0) ===
inline void inst_beq(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    out.valid = in.valid;
    out.rd = in.rd; // Usually 0/null for branches

    // 1. Comparison logic (rs1 == rs2)
    uint32_t in1 = in.val_rs1;
    uint32_t in2 = in.val_rs2;
    
    // We use SUB to check for equality (result 0 means equal)
    uint32_t comp_result = alu_execute(ALUOp::SUB, in1, in2);
    
    // 2. Calculate Potential Branch Target
    // PC + Immediate
    out.alu_result = alu_execute(ALUOp::ADD, in.pc, in.imm);

    // 3. Set Branch Metadata
    // The EX/MEM pipe needs to know if the branch was actually taken
    out.pc_modified = (comp_result == 0);
    
    // 4. Pass control signals forward
    out.val_rs2 = in.val_rs2;
    out.reg_write = in.reg_write; // Should be false for BEQ
    out.mem_read  = in.mem_read;
    out.mem_write = in.mem_write;

    LOG("BEQ: " + std::to_string(in1) + " == " + std::to_string(in2) + 
        " ? " + (out.pc_modified ? "TAKEN" : "NOT TAKEN"));
}