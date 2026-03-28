#include <fstream>
#include <vector>
#include <cstdint>
#include <cstring>
#include <stdexcept>
#include "Loader.hpp"
// ELF structures (minimal)


// --------------------------------------------------

uint32_t load_elf(const std::string& filename, Device& mem) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) {
        throw std::runtime_error("Failed to open ELF file");
    }

    // Read ELF header
    Elf32_Ehdr ehdr;
    file.read(reinterpret_cast<char*>(&ehdr), sizeof(ehdr));

    // Basic validation
    if (ehdr.e_ident[0] != 0x7f ||
        ehdr.e_ident[1] != 'E' ||
        ehdr.e_ident[2] != 'L' ||
        ehdr.e_ident[3] != 'F') {
        throw std::runtime_error("Not a valid ELF file");
    }

    // Check if it's a 32-bit ELF
    if (ehdr.e_ident[4] != 1) {  // EI_CLASS = ELFCLASS32 (1)
        throw std::runtime_error("Not a 32-bit ELF file");
    }

    // Check if it's for RISC-V
    if (ehdr.e_machine != EM_RISCV) {
        throw std::runtime_error("Not a RISC-V ELF file");
    }

    // Go to program headers
    file.seekg(ehdr.e_phoff, std::ios::beg);

    for (int i = 0; i < ehdr.e_phnum; i++) {
        Elf32_Phdr phdr;
        file.read(reinterpret_cast<char*>(&phdr), sizeof(phdr));

        if (phdr.p_type != PT_LOAD)
            continue;

        // Read segment data
        std::vector<uint8_t> segment(phdr.p_filesz);

        std::streampos current = file.tellg();
        file.seekg(phdr.p_offset, std::ios::beg);
        file.read(reinterpret_cast<char*>(segment.data()), phdr.p_filesz);

        // Write to memory
        mem.write(phdr.p_vaddr, segment.data(), phdr.p_filesz);

        // Zero-fill (BSS section)
        if (phdr.p_memsz > phdr.p_filesz) {
            size_t zero_size = phdr.p_memsz - phdr.p_filesz;
            std::vector<uint8_t> zeros(zero_size, 0);
            mem.write(phdr.p_vaddr + phdr.p_filesz, zeros.data(), zero_size);
        }

        // Restore file pointer
        file.seekg(current, std::ios::beg);
    }

    return ehdr.e_entry;  // Returns 32-bit entry point
}

uint32_t get_symbol(const std::string& filename, const std::string& symbol_name) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) return 0;

    Elf32_Ehdr ehdr;
    file.read(reinterpret_cast<char*>(&ehdr), sizeof(ehdr));

    // Read Section Headers
    std::vector<Elf32_Shdr> shdrs(ehdr.e_shnum);
    file.seekg(ehdr.e_shoff, std::ios::beg);
    file.read(reinterpret_cast<char*>(shdrs.data()), ehdr.e_shnum * sizeof(Elf32_Shdr));

    for (const auto& shdr : shdrs) {
        if (shdr.sh_type == SHT_SYMTAB) {
            // Find the associated String Table
            Elf32_Shdr strtab_shdr = shdrs[shdr.sh_link];
            std::vector<char> strtab(strtab_shdr.sh_size);
            file.seekg(strtab_shdr.sh_offset, std::ios::beg);
            file.read(strtab.data(), strtab_shdr.sh_size);

            // Read Symbols
            size_t num_syms = shdr.sh_size / sizeof(Elf32_Sym);
            std::vector<Elf32_Sym> syms(num_syms);
            file.seekg(shdr.sh_offset, std::ios::beg);
            file.read(reinterpret_cast<char*>(syms.data()), shdr.sh_size);

            for (const auto& sym : syms) {
                if (sym.st_name != 0 && std::string(&strtab[sym.st_name]) == symbol_name) {
                    return sym.st_value;
                }
            }
        }
    }
    return 0; // Symbol not found
}