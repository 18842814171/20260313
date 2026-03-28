# 1. Compile test source file
Test source file is named as: tests/*.c

Output file is: out/*.
* Assembly as reference
riscv64-unknown-elf-gcc -O0 -march=rv32i -mabi=ilp32 -S tests/simple.c -o out/simple.s
* ELF file: actual input
riscv64-unknown-elf-gcc -O0 -march=rv32i -mabi=ilp32 tests/simple.c -o out/simple32
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
./tests/debug.sh > out/out2.txt
```
Debug tips
```
n: next
s: step
c: continue(step out of the current loop)
cntl+Z: exit debug
print xxx: inspect the value or an address of a variable in the scope
```

