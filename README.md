# RISC-V 模拟器

## 编译模拟器

```bash
make
```

## 编译测试程序

```bash
./compile.sh asm tests/hello.s   # 汇编 -> ELF
./compile.sh c tests/hello.c     # C -> ELF
```

## 运行测试

```bash
./build/test --e0 out/hello      # 运行汇编程序
./build/test --e1 out/hello      # 运行完整程序 (Timer)
./build/test --e2 timer out/timer_uart_test # 测试设备 (timer/uart/all)
```

## 设备地址

| 设备  | 地址       |
|-------|------------|
| Timer | 0x02004000 |
| UART  | 0x10000000 |


# 交互
# 编译
make test-interactive

# 交互模式
./build/test_interactive

# 加载 ELF 后交互
./build/test_interactive out/timer_uart_test

# 加载 ELF 后自动运行 (默认 10000 步)
./build/test_interactive --run out/timer_uart_test

# 加载 ELF 后自动运行指定步数
./build/test_interactive --run 5000 out/timer_uart_test

# 帮助
./build/test_interactive --help