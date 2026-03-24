#include "Instmngr.hpp"

void InstManager::register_inst(int opcode, const std::string& name, InstFunc fn) {
    table_[opcode] = {fn, name};
}
std::string InstManager::get_name(int opcode) const {
    auto it = table_.find(opcode);
    return (it != table_.end()) ? it->second.name : "UNKNOWN";
}

size_t InstManager::size() const {
    return table_.size();
}

bool InstManager::has_instruction(uint32_t id) const {
        return table_.find(id) != table_.end();
    }
    
void InstManager::execute_inst(CPU& cpu, Memory& mem, const Inst& inst) {
        uint32_t id = inst.inst_id();
        auto it = table_.find(id);
        if (it != table_.end()) {
            it->second.handler(cpu, mem, inst);
            printf("Instruction ID 0x%08x\n", id);
        } else {
            printf("Error: Unknown Instruction ID 0x%08x\n", id);
        }
    }