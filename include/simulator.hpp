#ifndef SIMULATOR_HPP
#define SIMULATOR_HPP

#include <cstddef>
#include <string>

/**
 * 唯一模拟器入口：加载 ELF，默认挂载 Timer + UART，默认开启主机 stdin→UART RX。
 * @param max_steps 期望的最大周期数；0 表示使用 CPU::kDefaultRunStepLimit。
 *                  显式传入时实际执行不超过 min(max_steps, CPU::kHardAbsoluteRunStepLimit)。
 */
void simulator(std::string infile, size_t max_steps = 0, const std::string& map_json_path = "");

#endif
