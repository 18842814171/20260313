#include "Types.hpp"
#include "inst/add.hpp"  // 包含指令實現
#include <cstring>

CPU::CPU(Memory& mem_ref) : memory(mem_ref),
      inst_manager(new InstManager()) {
    reg[0] = 0;  // x0 永遠為 0
    init_instruction_table();
}

void CPU::init_instruction_table() {
    // 這裡註冊你已經寫好的指令函數
    // 建議用有意義的常量，而不是魔法數字
    // 可以定義在 utils/system.hpp 或單獨的 opcode.hpp
    //constexpr int OP_ADD  = 0x01;
    //constexpr int OP_SUB  = 0x02;
    //constexpr int OP_ADDI = 0x03;
    //constexpr int OP_LW   = 0x04;
    //constexpr int OP_SW   = 0x05;
    //constexpr int OP_BEQ  = 0x06;
    //constexpr int OP_JAL  = 0x07;

    // 假設你已經在 inst/ 目錄下實作了這些函數
    inst_manager->register_inst(OP_ADD,  inst_add);
    /*inst_manager->register_inst(OP_SUB,  inst_sub);
    inst_manager->register_inst(OP_ADDI, inst_addi);
    inst_manager->register_inst(OP_LW,   inst_lw);
    inst_manager->register_inst(OP_SW,   inst_sw);
    inst_manager->register_inst(OP_BEQ,  inst_beq);
    inst_manager->register_inst(OP_JAL,  inst_jal);
    */
    LOG("Instruction table initialized with " + std::to_string(inst_manager->size()) + " entries");
}

bool CPU::fetch_and_decode(uint32_t& raw, DecodedInst& d) {
     if (pc % 4 != 0) {
        std::cout << "CPU: Misaligned PC 0x" << std::hex << pc << std::endl;
        return false;
    }
    raw = memory.read(pc);
 

    // 基本欄位提取（之後可抽成獨立的 decoder 模組）
    d.opcode = raw & 0x7F;
    d.rd     = (raw >>  7) & 0x1F;
    d.funct3 = (raw >> 12) & 0x07;
    d.rs1    = (raw >> 15) & 0x1F;
    d.rs2    = (raw >> 20) & 0x1F;
    d.funct7 = (raw >> 25) & 0x7F;

    // 暫時用簡單方式決定唯一 ID（實際應根據 opcode + funct3 + funct7）
    uint32_t inst_id = d.opcode;

    if (d.opcode == 0b0110011) {        // R-type
        if (d.funct3 == 0x0 && d.funct7 == 0x00) inst_id = OP_ADD;
        //if (d.funct3 == 0x0 && d.funct7 == 0x20) inst_id = OP_SUB;
    }
    /*
    else if (d.opcode == 0b0010011) {   // I-type (addi ...)
        if (d.funct3 == 0x0) inst_id = OP_ADDI;
    }
    else if (d.opcode == 0b0000011) {   // load
        if (d.funct3 == 0x2) inst_id = OP_LW;
    }
    else if (d.opcode == 0b0100011) {   // store
        if (d.funct3 == 0x2) inst_id = OP_SW;
    }
    else if (d.opcode == 0b1100011) {   // branch
        if (d.funct3 == 0x0) inst_id = OP_BEQ;
    }
    else if (d.opcode == 0b1101111) {   // jal
        inst_id = OP_JAL;
    }
    */
    d.inst_id = inst_id;
    
    return true;
}

bool CPU::step() {
    PUSH;

    LOG("PC = 0x" + std::to_string(pc));

    uint32_t instr = 0;
    DecodedInst dec{};

    if (!fetch_and_decode(instr, dec)) {
        POP;
        return false;
    }

    LOG("Raw instr = 0x" + std::to_string(instr) + "  id = " + std::to_string(dec.inst_id));

    bool ok = inst_manager->execute(dec.inst_id, *this, memory, dec);

    if (!ok) {
        LOG("!!! Unimplemented or illegal instruction at PC=0x" + std::to_string(pc));
        POP;
        return false;
    }

    // x0 永遠保持 0（保險起見）
    reg[0] = 0;

    POP;
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

CPU::~CPU() {
    delete inst_manager;
    inst_manager = nullptr;
}