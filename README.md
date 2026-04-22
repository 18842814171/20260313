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
./build/test out/hello              # 运行 ELF（Timer+UART；日志见 log/）
./build/test out/hello 2000      # 同上，最多 100000 周期
```

汇编等可先编成 ELF 再运行。