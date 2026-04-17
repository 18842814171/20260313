#ifndef SIMULATOR_HPP
#define SIMULATOR_HPP

#include <string>
#include <tuple>

// 运行模拟器（非交互模式）
void simulator(std::string infile, size_t max_steps = 0);

// 运行模拟器（交互模式，支持键盘输入到 UART 和单步调试）
// enable_uart_input: 是否启用 UART 输入（用于程序需要读取键盘输入时）
// auto_run: true=自动连续运行, false=单步模式（按 'n' 执行一步）
void simulator_interactive(std::string infile, bool enable_uart_input = true, bool auto_run = true);

#endif