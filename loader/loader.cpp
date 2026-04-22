#include <fstream>
#include <vector>
#include <cstdint>
#include <cstring>
#include <stdexcept>
#include "Loader.hpp"
// ELF structures (minimal)


// --------------------------------------------------

uint32_t load_elf(const std::string& filename, Device& mem) {
    // Reset "last loaded elf" info for jump-range checks.
    loaded_elf_last_info() = LoadedElfInfo{};

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
    if (ehdr.e_ident[4] != 1) {
        throw std::runtime_error("Not a 32-bit ELF file");
    }

    // Check if it's for RISC-V
    if (ehdr.e_machine != EM_RISCV) {
        throw std::runtime_error("Not a RISC-V ELF file");
    }

    uint32_t entry = ehdr.e_entry;
    loaded_elf_last_info().entry = entry;

    // Try program headers first (EXEC/ET_DYN)
    if (ehdr.e_phoff > 0 && ehdr.e_phnum > 0) {
        for (int i = 0; i < ehdr.e_phnum; i++) {
            // Always read each PHDR from its table slot; segment reads below move file cursor.
            file.seekg(ehdr.e_phoff + static_cast<std::streamoff>(i) * sizeof(Elf32_Phdr), std::ios::beg);
            Elf32_Phdr phdr;
            file.read(reinterpret_cast<char*>(&phdr), sizeof(phdr));

            if (phdr.p_type != PT_LOAD || phdr.p_filesz == 0)
                continue;

            std::vector<uint8_t> segment(phdr.p_filesz);
            file.seekg(phdr.p_offset, std::ios::beg);
            file.read(reinterpret_cast<char*>(segment.data()), phdr.p_filesz);
            mem.write(phdr.p_vaddr, segment.data(), phdr.p_filesz);

            // Record LOAD segment virtual range [vaddr, vaddr+memsz)
            if (phdr.p_memsz > 0) {
                LoadedElfSegment seg;
                seg.begin = phdr.p_vaddr;
                seg.end = phdr.p_vaddr + phdr.p_memsz;
                loaded_elf_last_info().segments.push_back(seg);
            }

            if (phdr.p_memsz > phdr.p_filesz) {
                size_t zero_size = phdr.p_memsz - phdr.p_filesz;
                std::vector<uint8_t> zeros(zero_size, 0);
                mem.write(phdr.p_vaddr + phdr.p_filesz, zeros.data(), zero_size);
            }
        }
    }

    // Fallback: load .text section from section headers (for REL files or EXEC without PHDR)
    if (ehdr.e_shoff > 0 && ehdr.e_shnum > 0) {
        std::vector<Elf32_Shdr> shdrs(ehdr.e_shnum);
        file.seekg(ehdr.e_shoff, std::ios::beg);
        file.read(reinterpret_cast<char*>(shdrs.data()), ehdr.e_shnum * sizeof(Elf32_Shdr));

        for (const auto& shdr : shdrs) {
            if (shdr.sh_type == SHT_PROGBITS && (shdr.sh_flags & SHF_ALLOC) && shdr.sh_size > 0) {
                uint32_t vaddr = shdr.sh_addr;
                // For REL files (.text section has sh_addr=0), map to 0x10000
                if (vaddr == 0) {
                    vaddr = 0x10000;
                }

                std::vector<uint8_t> section(shdr.sh_size);
                file.seekg(shdr.sh_offset, std::ios::beg);
                file.read(reinterpret_cast<char*>(section.data()), shdr.sh_size);
                mem.write(vaddr, section.data(), shdr.sh_size);

                if (entry == 0 || entry < 0x10000)
                    entry = vaddr;

                // Record section load range [vaddr, vaddr+size) as a best-effort segment
                if (shdr.sh_size > 0) {
                    LoadedElfSegment seg;
                    seg.begin = vaddr;
                    seg.end = vaddr + static_cast<uint32_t>(shdr.sh_size);
                    loaded_elf_last_info().segments.push_back(seg);
                }
            }
        }
    }

    if (entry == 0)
        entry = 0x10000;

    loaded_elf_last_info().entry = entry;
    return entry;
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