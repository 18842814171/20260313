//CPU.cpp
#include "CPU.hpp"
#include "Pipe.hpp"
#include "Instmngr.hpp"   
#include "Device.hpp"
#include "utils/utils.hpp"
#define DEBUG 1s
#include <cstring>

CPU::CPU(Memory& mem_ref, InstManager& im_ref)
    : memory(mem_ref), inst_manager(im_ref)
{
    reg[0] = 0;
}

void CPU::fetch(Pipe& p) {
    p.pc = pc;
    p.inst = Inst(memory.read_word(pc));
}

void CPU::decode(Pipe& p) {
    p.inst_id = p.inst.inst_id();
    
    p.rs1 = p.inst.rs1();
    p.rs2 = p.inst.rs2();
    p.rd  = p.inst.rd();

    p.val_rs1 = reg[p.rs1];
    p.val_rs2 = reg[p.rs2];
    LOG("p.rs1:" + DEC(p.rs1));
    LOG("p.rs2:" + DEC(p.rs2));
    LOG("p.rd:" + DEC(p.rd));
    LOG("p.val_rs1:" + DEC(p.val_rs1));
    LOG("p.val_rs2:" + DEC(p.val_rs2));
    p.imm = p.inst.imm();
    LOG("p.imm:" + DEC(p.imm));
}

void CPU::memory_access(Pipe& p) {
    if (p.mem_read) {
        p.mem_data = memory.read_word(p.alu_result);
    } 
    else if (p.mem_write) {
        // p.val_rs2 contains the data to be stored (set during Decode)
        memory.write_word(p.alu_result, p.val_rs2);
    }
}

void CPU::writeback(Pipe& p) {
    // 1. Check if the instruction format even supports writing to rd
    // 2. Ensure we aren't trying to write to the hardwired zero register (x0)
    if (p.reg_write && p.rd != 0) {
        
        // If it's a load, use memory data; otherwise, use the ALU result
        if (p.mem_read) {
            reg[p.rd] = p.mem_data;
        } else {
            reg[p.rd] = p.alu_result; 
        }
    }
    printf("WB: rd=%u, alu=0x%08x, mem=0x%08x, write=%d\n",
       p.rd, p.alu_result, p.mem_data, p.reg_write);
    if (!p.pc_modified)
        pc += 4;
}

void CPU::execute(Pipe& p) {
    // We pass 'this' (the CPU), the memory reference, and the instruction
    // stored in the pipeline register to the manager.
    inst_manager.execute_inst(*this, p);
    
}

bool CPU::step()
{   
    
    Pipe p{};

    fetch(p);
    decode(p);
    execute(p);
    memory_access(p);
    writeback(p);

    return true;

}


void CPU::run(size_t max_steps) {
    
    size_t steps = 0;

    while (!halt) {
        if (max_steps && steps >= max_steps)
            break;

        if (!step())
            break;
        dump_registers();
        steps++;
    }

    LOG("Program exited with code: " + std::to_string(exit_code));
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

uint32_t CPU::calc_addr(const CPU& cpu, Inst inst) const{
    uint32_t rs1 = inst.rs1();
    int32_t  imm;

    if (inst.opcode() == OP_LOAD) {
        imm = inst.i_imm();           // I-type immediate
    } else {
        imm = inst.s_imm();           // S-type immediate
    }

    return cpu.reg[rs1] + static_cast<uint32_t>(imm);
    }
    