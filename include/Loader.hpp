#include "Device.hpp"
// ELF32 headers for RV32I
struct Elf32_Ehdr {
    unsigned char e_ident[16];
    uint16_t e_type;
    uint16_t e_machine;
    uint32_t e_version;
    uint32_t e_entry;      // 32-bit entry point
    uint32_t e_phoff;      // 32-bit program header offset
    uint32_t e_shoff;      // 32-bit section header offset
    uint32_t e_flags;
    uint16_t e_ehsize;
    uint16_t e_phentsize;
    uint16_t e_phnum;
    uint16_t e_shentsize;
    uint16_t e_shnum;
    uint16_t e_shstrndx;
};

struct Elf32_Phdr {
    uint32_t p_type;
    uint32_t p_offset;     // 32-bit offset
    uint32_t p_vaddr;      // 32-bit virtual address
    uint32_t p_paddr;      // 32-bit physical address
    uint32_t p_filesz;     // 32-bit file size
    uint32_t p_memsz;      // 32-bit memory size
    uint32_t p_flags;
    uint32_t p_align;
};

struct Elf32_Shdr {
    uint32_t sh_name;
    uint32_t sh_type;
    uint32_t sh_flags;
    uint32_t sh_addr;
    uint32_t sh_offset;
    uint32_t sh_size;
    uint32_t sh_link;
    uint32_t sh_info;
    uint32_t sh_addralign;
    uint32_t sh_entsize;
};

struct Elf32_Sym {
    uint32_t st_name;
    uint32_t st_value;
    uint32_t st_size;
    unsigned char st_info;
    unsigned char st_other;
    uint16_t st_shndx;
};


#define SHT_SYMTAB 2
#define PT_LOAD 1
#define EM_RISCV 243  // RISC-V machine type

uint32_t load_elf(const std::string& filename, Device& mem);
uint32_t get_symbol(const std::string& filename, const std::string& symbol_name);

// Get argc and argv from command line, store them on stack and return argc
// This is called before starting CPU to set up proper environment
struct ArgvInfo {
    uint32_t argc;
    uint32_t argv_addr;
    uint32_t sp;
};

inline ArgvInfo setup_args_for_elf(const std::string& filename, 
                                     uint32_t stack_base, 
                                     Device& mem) {
    // For now, we run with argc=0 (no command line args)
    // Store argc and a null argv pointer on stack
    ArgvInfo info;
    info.argc = 0;
    info.argv_addr = stack_base;  // argv points to argc
    
    // Write argc at stack_base
    uint8_t data[4];
    for (int i = 0; i < 4; i++) {
        data[i] = (0 >> (i * 8)) & 0xFF;
    }
    mem.write(stack_base, data, 4);
    
    // Write null argv[0] (end of argv array)
    for (int i = 0; i < 4; i++) {
        data[i] = 0;
    }
    mem.write(stack_base + 4, data, 4);
    
    info.sp = stack_base + 8;  // sp after argc and argv[0]
    return info;
}