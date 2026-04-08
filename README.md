# 1. Compile test source file
Test source file is named as: tests/*.c

Output file is: out/*.
* Assembly as reference
riscv64-unknown-elf-gcc -O0 -march=rv32i -mabi=ilp32 -S tests/simple.c -o out/simple.s
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -S tests/simple.c -o out/simple.s
* ELF file: actual input
riscv64-unknown-elf-gcc -O0 -march=rv32i -mabi=ilp32 tests/simple.c -o out/simple32
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 tests/simple.c -o out/simple32
* Check ELF file structure
riscv64-unknown-elf-objdump -d out/simple32
# 2. Run test script
Test scripts are in tests/.
* Running mode:(make sure file path is correct in the script)
```
./tests/test1.sh > out/out1.txt
```
out1.txt records all loggings.

* Debug mode:(make sure file path is correct in the script)
```
./tests/debug.sh 
```
Debug tips
```
n: next
s: step
c: continue(step out of the current loop)
cntl+Z: exit debug
print xxx: inspect the value or an address of a variable in the scope
```

# 1. 汇编：.s → .o（目标文件）
riscv64-unknown-elf-as -march=rv32i program.s -o program.o

# 2. 转二进制：.o → .bin（纯机器码）
riscv64-unknown-elf-objcopy -O binary program.o program.bin
riscv64-unknown-elf-objdump -d program.o

Usage: ./build/test [OPTIONS]

Test options:
  --e0 [file]    Execute simple assembly program (default: tests/simple_asm.s)
  --e1 <file>    Run compiled full program
  --e2           Test interrupt functionality
  --e3 <file>    Run tests with external device

Examples:
  ./build/test --e0
  ./build/test --e0 tests/simple_asm.s
  ./build/test --e1 out/simple32
  ./build/test --e2
  ./build/test --e3 out/simple32


