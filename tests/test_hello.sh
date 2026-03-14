#!/bin/bash
# tests/test_hello.sh


source_file="$1"
target_file="$2"

riscv64-unknown-elf-gcc "$source_file" -o "$target_file"

file "$target_file"

riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 "$source_file" -o hello32
file hello32

riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -nostdlib "$source_file" -o hello-32
file hello-32