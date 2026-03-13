#!/bin/bash
# tests/test_hello.sh

source_file="$1"
target_file="$2"

# 使用变量时需要加 $ 符号
riscv64-unknown-elf-gcc "$source_file" -o "$target_file"

# 查看生成的文件信息
file "$target_file"
