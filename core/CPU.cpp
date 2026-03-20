//CPU.cpp
#include "CPU.hpp"
// Standard practice: include the header for this class first
#include "Instmngr.hpp"   // NOW the compiler knows what 'new InstManager()' means
#include "Memory.hpp"
#include <cstring>
#include "decode.hpp"
CPU::CPU(Memory& mem_ref) : memory(mem_ref),
      inst_manager(new InstManager()) {
    reg[0] = 0;  // x0 永遠為 0
    init_instruction_table();
}

void CPU::init_instruction_table() {

    // 假設你已經在 inst/ 目錄下實作了這些函數
    inst_manager->register_all_instructions();
    /*inst_manager->register_inst(OP_SUB,  inst_sub);
    inst_manager->register_inst(OP_ADDI, inst_addi);
    inst_manager->register_inst(OP_LW,   inst_lw);
    inst_manager->register_inst(OP_SW,   inst_sw);
    inst_manager->register_inst(OP_BEQ,  inst_beq);
    inst_manager->register_inst(OP_JAL,  inst_jal);
    */
    LOG("Instruction table initialized with " + std::to_string(inst_manager->size()) + " entries");
}

bool CPU::step()
{   
    LOG("===== STEP =====");
    LOG("PC = " + std::to_string(pc));
        
    uint32_t raw = memory.read(pc);
    
    LOG("RAW = " + std::to_string(raw));
    Inst inst(raw);
    LOG("Decoded:");
    PUSH;

    LOG("opcode = " + std::to_string(inst.opcode()));
    LOG("rd = " + std::to_string(inst.rd()));
    LOG("rs1 = " + std::to_string(inst.rs1()));
    LOG("rs2 = " + std::to_string(inst.rs2()));

    POP;
    inst_manager->execute(*this, memory, inst);

    pc += 4;

    return true;
}


void CPU::run(size_t max_steps) {
    size_t count = 0;
    while (max_steps == 0 || count < max_steps) {
        GAP;
        LOG("Step " + std::to_string(count + 1));
        if (!step()) {
            LOG("Execution stopped.");
            break;
        }
        count++;
    }
}

void CPU::dump_registers() const {
    for (int i = 0; i < 32; i += 4) {
        printf("x%02d: 0x%08x   x%02d: 0x%08x   x%02d: 0x%08x   x%02d: 0x%08x\n",
               i, reg[i], i+1, reg[i+1], i+2, reg[i+2], i+3, reg[i+3]);
    }
    printf(" pc: 0x%08x\n", pc);
}

void CPU::dump_state(const std::string& prefix) const {
    LOG(prefix + "  PC = 0x" + std::to_string(pc));
    // 可選擇性印出常用暫存器，例如 a0~a7, sp, ra 等
}

std::string CPU::get_inst_name(uint32_t opcode) const {
        return inst_manager->get_name(opcode);
    }

CPU::~CPU() {
    delete inst_manager;
    inst_manager = nullptr;
}