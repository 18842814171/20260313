#include "Instmngr.hpp"
#include "CPU.hpp"
#include "Memory.hpp"
#include "decode.hpp"

// Include all instruction logic here
#include "inst/add.hpp"
#include "inst/opcode.hpp" // For INST_ADD, etc.

void InstManager::register_inst(int opcode, const std::string& name, InstFunc fn) {
    table_[opcode] = {fn, name};
}

void InstManager::register_all_instructions() {
    // Now inst_add is in scope because of the include above!
    register_inst(OP_ADD, "ADD", inst_add);
    // Add more as you go:
    // register_inst(OP_SUB, "SUB", inst_sub);
}

void InstManager::execute(CPU& cpu, Memory& mem, const Inst& inst) {
    uint32_t id = inst.inst_id();
    if (table_.count(id)) {
        table_[id].handler(cpu, mem, inst);
    } else {
        // Handle unknown instruction
        printf("Error: Unknown Instruction ID 0x%08x\n", id);
    }
}

std::string InstManager::get_name(int opcode) const {
    auto it = table_.find(opcode);
    return (it != table_.end()) ? it->second.name : "UNKNOWN";
}

size_t InstManager::size() const {
    return table_.size();
}