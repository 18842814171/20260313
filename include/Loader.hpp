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

#define PT_LOAD 1
#define EM_RISCV 243  // RISC-V machine type
uint32_t load_elf(const std::string& filename, Device& mem);