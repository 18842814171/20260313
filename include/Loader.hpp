#include "device/Device.hpp"
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
#define SHT_PROGBITS 1
#define SHF_ALLOC 0x2
#define PT_LOAD 1
#define EM_RISCV 243

uint32_t load_elf(const std::string& filename, Device& mem);
uint32_t get_symbol(const std::string& filename, const std::string& symbol_name);

// Get argc and argv from command line, store them on stack and return argc
// This is called before starting CPU to set up proper environment
struct ArgvInfo {
    uint32_t argc;
    uint32_t argv_addr;
    uint32_t sp;
};

/** 已加载 ELF 的可执行/可访问段范围（来自 PT_LOAD 或 section fallback）。 */
struct LoadedElfSegment {
    uint32_t begin; // inclusive
    uint32_t end;   // exclusive
};

/** 加载 ELF 的结果：entry + 各 LOAD 段范围。 */
struct LoadedElfInfo {
    uint32_t entry = 0;
    std::vector<LoadedElfSegment> segments;
};

/** 判断 addr 是否落在任一已加载段中。 */
inline bool loaded_elf_contains(const LoadedElfInfo& info, uint32_t addr) {
    for (const auto& s : info.segments) {
        if (addr >= s.begin && addr < s.end)
            return true;
    }
    return false;
}

/** 让 CPU/Simulator 获取当前 ELF 装载段信息（由 load_elf 填充）。 */
inline LoadedElfInfo& loaded_elf_last_info() {
    static LoadedElfInfo last;
    return last;
}

inline void setup_write_u32_le(Device& mem, uint32_t addr, uint32_t v) {
    uint8_t d[4];
    d[0] = static_cast<uint8_t>(v & 0xff);
    d[1] = static_cast<uint8_t>((v >> 8) & 0xff);
    d[2] = static_cast<uint8_t>((v >> 16) & 0xff);
    d[3] = static_cast<uint8_t>((v >> 24) & 0xff);
    mem.write(addr, d, 4);
}

/**
 * 构造 RISC-V psABI 的 _start 参数：a0=argc, a1=argv（指向 char* 数组，而非 argc 本体）。
 * 使用 argc=1、argv[0] 指向空串，argv[1]=NULL，避免 newlib 将 argc 误当作指针而跑飞。
 */
inline ArgvInfo setup_args_for_elf(const std::string& filename,
                                     uint32_t stack_base,
                                     Device& mem) {
    (void)filename;
    ArgvInfo info;
    const uint32_t base = stack_base;
    const uint32_t str_addr = base + 12u;

    setup_write_u32_le(mem, base + 0u, 1u);           // argc
    setup_write_u32_le(mem, base + 4u, str_addr);    // argv[0] -> "\0"
    setup_write_u32_le(mem, base + 8u, 0u);           // argv[1] = NULL
    uint8_t z = 0;
    mem.write(str_addr, &z, 1);

    info.argc = 1;
    info.argv_addr = base + 4u;
    info.sp = (base + 16u + 15u) & ~15u;
    return info;
}