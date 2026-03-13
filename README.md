RISC-V GNU Toolchain 通用编译/验证
$riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 hello.c -o hello32
$file hello32
hello32: ELF 32-bit LSB executable, UCB RISC-V, version 1 (SYSV), 
statically linked, with debug_info, not stripped
$riscv64-unknown-elf-gcc hello.c -o hello64
$file hello64
hello64: ELF 64-bit LSB executable, UCB RISC-V, version 1 (SYSV), 
statically linked, not stripped

front:elf_loader---
cpu
||bus
memory


bus:queue---message
# 20260313
