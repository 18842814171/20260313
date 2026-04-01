//CPU.cpp
#include "CPU.hpp"
#include "Pipe.hpp"
#include "Instmngr.hpp"   
#include "Device.hpp"
#include "utils/utils.hpp"
#define DEBUG 1
#include <cstring>

CPU::CPU(Memory& mem_ref, InstManager& im_ref)
    : memory(mem_ref), inst_manager(im_ref)
{
    reg[0] = 0;
}

void CPU::fetch(Pipe_IF_ID& out) {
    if (halt) return;
    SCOPE;
    out.valid = true;
    out.pc = pc;

    out.inst = Inst(memory.read_word(pc));
    LOG("pc: "+HEX(out.pc));
    pc += 4;  // simple sequential
}

void CPU::decode(Pipe_IF_ID& in, Pipe_ID_EX& out) {
    SCOPE;
    if (!in.valid) {
        
        LOG("Invalid PC at: " + HEX(in.pc));
        out.valid = false;
        return;
    }

    out.valid = true;

    out.pc = in.pc;
    out.inst_id = in.inst.inst_id();

    out.rs1 = in.inst.rs1();
    out.rs2 = in.inst.rs2();
    out.rd  = in.inst.rd();

    out.val_rs1 = reg[out.rs1];
    out.val_rs2 = reg[out.rs2];

    out.imm = in.inst.imm();

    out.reg_write = false;
    out.mem_read  = false;
    out.mem_write = false;

    switch (out.inst_id) {
        case INST_ADD:
            out.reg_write = true;
            out.alu_src = false;
            out.alu_op = ALUOp::ADD;
            break;

        case INST_ADDI:
            out.reg_write = true;
            out.alu_src = true;
            out.alu_op = ALUOp::ADD;
            break;

        case INST_LW:
            out.reg_write = true;
            out.mem_read = true;
            out.alu_src = true;
            break;

        case INST_SW:
            out.mem_write = true;
            out.alu_src = true;
            out.reg_write = false;
            break;
    }
    LOG("decode instruction address = " + HEX(out.pc));
    LOG("decoded inst = " + get_inst_name(out.inst_id));
    
    LOG("rs1:" + DEC(out.rs1));
    LOG("rs2:" + DEC(out.rs2));
    LOG("rd:" + DEC(out.rd));
    LOG("val_rs1:" + DEC(out.val_rs1));
    LOG("val_rs2:" + DEC(out.val_rs2));
    
    LOG("imm:" + DEC(out.imm));
}

void CPU::execute(Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    if (!in.valid) {
        out.valid = false;
        return;
    }
    SCOPE;
    inst_manager.execute_inst(*this, in, out);
}

void CPU::memory_access(Pipe_EX_MEM& in, Pipe_MEM_WB& out) {
    SCOPE;
    if (!in.valid) {
        out.valid = false;
        exit_code = reg[10];  // Or whatever exit code logic you need
        LOG("Invalid PC: " + HEX(in.pc));
        return;
    }

    out.valid = true;

    out.rd = in.rd;
    out.alu_result = in.alu_result;

    out.reg_write = in.reg_write;
    out.mem_read  = in.mem_read;

    if (in.mem_read) {
        LOG("LW addr = " + HEX(out.alu_result));
        out.mem_data = memory.read_word(in.alu_result);
    }
    else if (in.mem_write) {
        LOG("SW addr = " + HEX(out.alu_result));
        memory.write_word(in.alu_result, in.val_rs2);
    }
}

void CPU::writeback(Pipe_MEM_WB& in) {
    SCOPE;
    if (!in.valid) return;

    if (in.reg_write && in.rd != 0) {
        uint32_t data = in.mem_read ? in.mem_data : in.alu_result;
        reg[in.rd] = data;
        LOG("WB: rd=" + DEC(in.rd) + ", data=" + HEX(data));
    }
}

bool CPU::step()
{    
   
    GAP;
    SCOPE; 
    if (halt) return false;
    writeback(mem_wb);
    memory_access(ex_mem, mem_wb);
    execute(id_ex, ex_mem);
    decode(if_id, id_ex);
    fetch(if_id);
    return true;
} 

void CPU::run(size_t max_steps) {
    
    size_t steps = 0;
    
    while (!halt) {
        if (max_steps && steps >= max_steps)
            break;
        GAP;
        LOG("Step: " + DEC(steps));
        GAP;
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
    printf("dump registers state pc: 0x%08x\n", pc);
}

void CPU::dump_state(const std::string& prefix) const {
    LOG(prefix + "  PC = " + HEX(pc));
    
}

std::string CPU::get_inst_name(uint32_t opcode) const {
        return inst_manager.get_name(opcode);
    }


CPU::~CPU() {
    
}

