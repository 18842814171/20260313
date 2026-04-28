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
| Display (MMIO ctrl) | 0x10001000 |


# Entry

```bash
./build/test hello                 # 自动尝试 ./hello、out/hello、tests/hello
./build/test hello 2000            # 同上，可加运行步数上限
```

汇编等可先编成 ELF 再运行。

# New: plotting device for maps
```bash
./compile.sh c tests/map_device_caller_test.c

./build/test map_device_caller_test --map=maploader_sample
```
# New: to waveform
./build/test xxx --debug=1 --log-steps=2000

# 转波形 JSON
./build/waveform xxx wave.json --max-wave-steps=2000
```

maps and waveforms will be generated under plot/.