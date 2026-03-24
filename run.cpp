//run.cpp
#include"utils/utils.hpp"
#include "CPU.hpp"
#include "Instmngr.hpp"
#include "Memory.hpp"
#include "Loader.hpp"
int main(){
    Memory mem;  
    CPU cpu(mem);  
    uint32_t entry_point = load_elf("/home/linda/3.8/my_sim/output/simple32", mem);

    // Start execution at entry_point
    LOG ("Program entry point: 0x"+ HEX(entry_point));
    return 0;
}