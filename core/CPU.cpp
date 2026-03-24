//CPU.cpp
#include "CPU.hpp"
// Standard practice: include the header for this class first
#include "Instmngr.hpp"   
#include "Memory.hpp"
#include <cstring>
#include "Decoder.hpp"
CPU::CPU(Memory& mem_ref, InstManager& im_ref)
    : memory(mem_ref), inst_manager(im_ref)
{
    reg[0] = 0;
}


bool CPU::step()
{   
    LOG("===== STEP =====");
    LOG("PC = " + std::to_string(pc));
        
    uint32_t raw = memory.read_word(pc);
    
    LOG("RAW = " + std::to_string(raw));
    Inst inst(raw);
    LOG("Decoded:");
    PUSH;

    LOG("opcode = " + std::to_string(inst.opcode()));
    LOG("rd = " + std::to_string(inst.rd()));
    LOG("rs1 = " + std::to_string(inst.rs1()));
    LOG("rs2 = " + std::to_string(inst.rs2()));

    POP;
    inst_manager.execute_inst(*this, memory, inst);

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
    
}

std::string CPU::get_inst_name(uint32_t opcode) const {
        return inst_manager.get_name(opcode);
    }


CPU::~CPU() {
    
}