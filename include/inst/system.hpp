// include/inst/system.hpp
#ifndef INST_SYSTEM_HPP
#define INST_SYSTEM_HPP
#include "utils/utils.hpp"
#include "Pipe.hpp"
#include <iostream>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>

#define DEBUG 1

// Forward declaration
class CPU;

inline void inst_ebreak(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)in;
    (void)out;
    cpu.halt = true;
    cpu.exit_code = -1;
    LOG("EBREAK: Halting");
}

// Enhanced syscall handling function
inline int handle_syscall(CPU& cpu) {
    uint32_t syscall_num = cpu.reg[17];
    uint32_t arg0 = cpu.reg[10];
    uint32_t arg1 = cpu.reg[11];
    uint32_t arg2 = cpu.reg[12];
    uint32_t arg3 = cpu.reg[13];
    int ret = 0;

    switch (syscall_num) {
        case 93: { // exit
            LOG("SYSCALL: exit(" + std::to_string(arg0) + ")");
            cpu.halt = true;
            cpu.exit_code = static_cast<int>(arg0);
            break;
        }

        case 64: { // write
            uint32_t fd = arg0;
            uint32_t buf_addr = arg1;
            uint32_t count = arg2;
            
            if (fd == 1 || fd == 2) { // stdout or stderr
                Memory& mem = cpu.get_memory();
                for (uint32_t i = 0; i < count; ++i) {
                    uint32_t word = mem.read_word(buf_addr + i * 4);
                    for (int j = 0; j < 4; ++j) {
                        char c = static_cast<char>(word & 0xFF);
                        if (j < static_cast<int>(count - i * 4)) {
                            std::cout << c;
                        }
                        word >>= 8;
                    }
                }
                ret = static_cast<int>(count);
            } else {
                ret = -1;
            }
            cpu.reg[10] = static_cast<uint32_t>(ret);
            LOG("SYSCALL: write(fd=" + std::to_string(fd) + ", len=" + std::to_string(count) + ") = " + std::to_string(ret));
            break;
        }

        case 63: { // read
            uint32_t fd = arg0;
            uint32_t buf_addr = arg1;
            uint32_t count = arg2;
            
            char buf[256];
            ssize_t n = read(fd, buf, count < 256 ? count : 256);
            if (n > 0) {
                Memory& mem = cpu.get_memory();
                for (ssize_t i = 0; i < n; ++i) {
                    mem.write_word(buf_addr + i * 4, static_cast<uint32_t>(buf[i]));
                }
            }
            ret = static_cast<int>(n);
            cpu.reg[10] = static_cast<uint32_t>(ret);
            LOG("SYSCALL: read(fd=" + std::to_string(fd) + ", len=" + std::to_string(count) + ") = " + std::to_string(ret));
            break;
        }

        case 9: { // brk
            static uint32_t brk_val = 0x80000;
            if (arg0 == 0) {
                cpu.reg[10] = brk_val;
            } else {
                brk_val = arg0;
                cpu.reg[10] = 0;
            }
            LOG("SYSCALL: brk");
            break;
        }

        case 220: { // gettimeofday
            struct timeval tv;
            gettimeofday(&tv, nullptr);
            cpu.reg[10] = static_cast<uint32_t>(tv.tv_sec);
            cpu.reg[11] = static_cast<uint32_t>(tv.tv_usec);
            LOG("SYSCALL: gettimeofday");
            break;
        }

        case 17: { // getpid
            cpu.reg[10] = 1;
            LOG("SYSCALL: getpid");
            break;
        }

        case 62: { // lseek
            uint32_t fd = arg0;
            off_t offset = static_cast<off_t>(arg2);
            int whence = static_cast<int>(arg2);
            off_t pos = lseek(fd, offset, whence);
            ret = (pos >= 0) ? static_cast<int>(pos) : -1;
            cpu.reg[10] = static_cast<uint32_t>(ret);
            LOG("SYSCALL: lseek");
            break;
        }

        case 56: { // open
            LOG("SYSCALL: open (not fully implemented)");
            cpu.reg[10] = static_cast<uint32_t>(-1);
            break;
        }

        case 57: { // close
            LOG("SYSCALL: close");
            ret = 0;
            cpu.reg[10] = static_cast<uint32_t>(ret);
            break;
        }

        case 80: { // fstat
            LOG("SYSCALL: fstat (not fully implemented)");
            cpu.reg[10] = static_cast<uint32_t>(-1);
            break;
        }

        default:
            LOG("SYSCALL: unknown syscall " + std::to_string(syscall_num));
            cpu.reg[10] = static_cast<uint32_t>(-1);
            break;
    }
    return ret;
}

inline void inst_ecall(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {
    (void)in;
    (void)out;
    
    // Handle syscall using the enhanced handler
    handle_syscall(cpu);
    
    // If the syscall was exit, halt will be set by the handler
    // Otherwise, we continue execution
    if (cpu.halt) {
        LOG("ECALL: CPU halted with exit code " + std::to_string(cpu.exit_code));
    } else {
        LOG("ECALL: syscall handled, a0 = " + std::to_string(cpu.reg[10]));
    }
}

enum {
    SYSCALL_EXIT = 93,
    SYSCALL_READ = 63,
    SYSCALL_WRITE = 64,
    SYSCALL_OPEN = 56,
    SYSCALL_CLOSE = 57,
    SYSCALL_LSEEK = 62,
    SYSCALL_BRK = 9,
    SYSCALL_GETPID = 17,
    SYSCALL_GETTIMEOFDAY = 220,
    SYSCALL_MMAP = 222,
};

#endif