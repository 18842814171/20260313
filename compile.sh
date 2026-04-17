#!/bin/bash
# compile.sh - RISC-V 编译脚本
#
# 用法:
#   ./compile.sh asm <file.s>       # 汇编 -> ELF
#   ./compile.sh c <file.c>         # C -> ELF
#   ./compile.sh dump <file>         # 反汇编 ELF
#   ./compile.sh run <elf>          # 运行 ELF (非交互)
#   ./compile.sh runi <elf>         # 运行 ELF (交互模式)

set -e

CMD=${1:-}
SRC=${2:-}
OUT_DIR="out"
INTERACTIVE=false

# 交互式确认函数
ask_interactive() {
    echo ""
    echo "是否启用交互模式？"
    echo "  y - 交互模式: 键盘输入会传递给程序的 UART RX"
    echo "  n - 普通模式: 直接运行到结束"
    echo -n "选择 (y/n): "
    read -r ans
    case "$ans" in
        y|Y) INTERACTIVE=true ;;
        *)  INTERACTIVE=false ;;
    esac
}

run_elf() {
    local elf="$1"
    local interactive="$2"

    if [ ! -f "$elf" ]; then
        echo "错误: 文件不存在: $elf"
        exit 1
    fi

    echo "加载 ELF: $elf"
    if [ "$interactive" = "true" ]; then
        echo "交互模式: 键盘输入会传递给程序的 UART"
        echo "按 Ctrl+C 可中断程序"
        echo ""
        ./build/test_interactive -i "$elf"
    else
        ./build/test_interactive "$elf"
    fi
}

case "$CMD" in
    asm)
        BASENAME=$(basename "$SRC" .s)
        riscv64-unknown-elf-as -march=rv32i "$SRC" -o "$OUT_DIR/${BASENAME}.o"
        echo "OK: $OUT_DIR/${BASENAME}"
        ;;

    c)
        BASENAME=$(basename "$SRC" .c)
        riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 "$SRC" -o "$OUT_DIR/${BASENAME}"
        echo "OK: $OUT_DIR/${BASENAME}"
        ;;

    dump)
        riscv64-unknown-elf-objdump -d "$SRC"
        ;;

    run)
        ask_interactive
        run_elf "$SRC" "$INTERACTIVE"
        ;;

    runi)
        run_elf "$SRC" "true"
        ;;

    *)
        echo "用法: $0 <command> <file>"
        echo ""
        echo "命令:"
        echo "  asm   <file.s>  汇编 -> 二进制"
        echo "  c     <file.c>  C -> 二进制"
        echo "  dump  <file>    反汇编"
        echo "  run   <elf>     运行 ELF (交互式选择)"
        echo "  runi  <elf>     运行 ELF (强制交互模式)"
        exit 1
        ;;
esac
