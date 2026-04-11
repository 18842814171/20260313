#!/bin/bash
# compile.sh - RISC-V 编译脚本
#
# 用法:
#   ./compile.sh asm <file.s>   # 汇编 -> ELF
#   ./compile.sh c <file.c>     # C -> ELF
#   ./compile.sh dump <file>    # 反汇编 ELF

set -e

CMD=${1:-}
SRC=${2:-}
OUT_DIR="out"

mkdir -p "$OUT_DIR"

case "$CMD" in
    asm)
        BASENAME=$(basename "$SRC" .s)
        riscv64-unknown-elf-as -march=rv32i "$SRC" -o "$OUT_DIR/${BASENAME}.o"
        echo "OK: $OUT_DIR/$BASENAME"
        ;;

    c)
        BASENAME=$(basename "$SRC" .c)
        riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 "$SRC" -o "$OUT_DIR/$BASENAME"
        echo "OK: $OUT_DIR/$BASENAME"
        ;;

    dump)
        riscv64-unknown-elf-objdump -d "$SRC"
        ;;

    *)
        echo "用法: $0 <command> <file>"
        echo ""
        echo "命令:"
        echo "  asm  <file.s>  汇编 -> ELF"
        echo "  c    <file.c>  C -> ELF"
        echo "  dump <file>    反汇编 ELF"
        exit 1
        ;;
esac
