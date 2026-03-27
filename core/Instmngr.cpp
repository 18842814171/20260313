#include "Instmngr.hpp"
#include "CPU.hpp"
#include "utils/utils.hpp"
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
    
void InstManager::execute_inst(CPU& cpu, Pipe& p) {
        uint32_t id = p.inst_id;
        if (id == 0) {
        LOG("Skipping unsupported SYSTEM instruction");
        return;
    }
        auto it = table_.find(id);
        if (it != table_.end()) {
            const auto& entry = it->second;
            LOG("Instruction ID "+entry.name+HEX(id));
            entry.handler(cpu, p); 
        } else {
            LOG("Error: Unknown Instruction ID "+ HEX(id));
            //cpu.halt = true;
        }
    }

