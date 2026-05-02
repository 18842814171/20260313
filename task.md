[串口] WebSocket 已连接
[ready]
bash: cannot set terminal process group (139829): Inappropriate ioctl for device
bash: no job control in this shell
//uart cannot work properly and the interactive program did not run interactively the last time
[?2004h]0;linda@000000: ~/3.8/my_sim[01;32mlinda@000000[00m:[01;34m~/3.8/my_sim[00m$ 
[运行] ./build/test io 1000 --debug=1 --log-steps=1000
^C

[提示] 未填批量行时，请在程序提示后在下方输入框手动发送字符（如 q）

$ ./build/test io 1000 --debug=1 --log-steps=1000; echo __SERIAL_DONE_1777723539256__
./build/test io 1000 --debug=1 --log-steps=1000; echo __SERIAL_DONE_1777723539256__
[?2004l

=== 运行前（设备/内存/统计） ===
主存: 容量 4194304 bytes, 基址 0x10000
      已写入最高字节地址 0x2000c (相对基址 +65548 bytes)
Timer MTIME: 0
UART: TX 字符(送主机) 0, RX 字符(程序已读走) 0, 当前 RX FIFO 0
  寄存器读次数合计: 0  写次数合计: 0
  各寄存器读/写 (x0 也会统计读端口占用):

[UART: 主机键盘 → MMIO RX；Ctrl+C 结束 stdin 线程]
[模拟器] 本次步数上限(请求) 1000，硬顶 CPU::kHardAbsoluteRunStepLimit=100000000
=== UART mixe[模拟器] 已达步数上限 1000，未通过 ECALL 正常退出。请检查死循环，或显式传入更大的 max_steps（受 CPU::kHardAbsoluteRunStepLimit 硬顶）；max_steps==0 时默认上限为 CPU::kDefaultRunStepLimit。

=== 运行后（设备/内存/统计） ===
主存: 容量 4194304 bytes, 基址 0x10000
      已写入最高字节地址 0x2000f (相对基址 +65551 bytes)
Timer MTIME: 1000
UART: TX 字符(送主机) 13, RX 字符(程序已读走) 0, 当前 RX FIFO 0
  寄存器读次数合计: 1156  写次数合计: 393
