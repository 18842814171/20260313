#include "Instmngr.hpp"
#include "CPU.hpp"
#include "utils/utils.hpp"
void InstManager::register_inst(uint32_t inst_id, const std::string& name, InstFunc fn) {
    table_[inst_id] = {fn,name}; 
}

// 2. Define lookup outside as its own member function
const InstEntry* InstManager::lookup(uint32_t inst_id) const {
    auto it = table_.find(inst_id);
    if (it != table_.end()) {
        return &it->second;
    }
    return nullptr;
}
std::string InstManager::get_name(uint32_t inst_id) const {
    auto it = table_.find(inst_id);
    return (it != table_.end()) ? it->second.name : "UNKNOWN";
}

size_t InstManager::size() const {
    return table_.size();
}

bool InstManager::has_instruction(uint32_t id) const {
        return table_.find(id) != table_.end();
    }
    

void InstManager::execute_inst(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    SCOPE;
    if (!in.valid) return;
    uint32_t id = in.inst_id;
    LOG("execute_inst: id=" + HEX(id) + " (" + get_name(id) + ")");
    auto it = table_.find(id);
    if (it != table_.end()) {
        const auto name = it->second.name;
        LOG("Instruction ID " + name + " " + HEX(id));
        it->second.handler(cpu, in, out);
    }
    else {
        LOG("Error: Unknown Instruction ID " + HEX(id));
    }
}

