#include "utils/utils.hpp"
#include "CPU.hpp"     

#include "Pipe.hpp"
#include "ALU.hpp"
#define DEBUG 1
// === B-type: BEQ (opcode 0x63, funct3=0) ===
inline void inst_beq(CPU& cpu,  Pipe& p) {
   
    LOG("*************");
    // 1. Set Control Signals
    p.alu_src = false;        // Compare rs1 and rs2
    
    p.reg_write = false;      // CRITICAL: Branches do NOT write to registers
    
    // 2. Execution
    uint32_t in1 = p.val_rs1;
    uint32_t in2 = p.val_rs2; // Since alu_src is false
    p.alu_result = alu_execute(ALUOp::SUB, in1, in2);
    p.next_pc = alu_execute(ALUOp::ADD, p.pc, p.imm);
    // 3. Tracking the "Taken" Status
    // If (in1 - in2 == 0), then in1 == in2, and the branch is taken.
    p.pc_modified = (p.alu_result == 0);
    
    // 5. Logging
    LOG("Comparison: " + std::to_string(in1) + " == " + std::to_string(in2));
    LOG("Branch Taken: " + std::string(p.pc_modified ? "YES" : "NO"));
     
}