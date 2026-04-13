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



## 设备地址

| 设备  | 地址       |
|-------|------------|
| Timer | 0x02004000 |
| UART  | 0x10000000 |


# 非交互式

```bash
./build/test --e0 out/hello      # 运行汇编程序
./build/test --e1 out/hello      # 运行完整程序 (Timer)
./build/test --e2 timer out/timer_uart_test # 测试设备 (timer/uart/all)
```

# 交互
## 编译
make test-interactive

## 交互模式运行
./build/test_interactive


## 交互模式帮助
./build/test_interactive --help