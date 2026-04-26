/**
 * @file test.cpp - 唯一测试入口
 * CLI schema:
 *   ./build/test <elf> [max_steps] [--debug=0|1] [--map=<json>|--map <json>]
 */

#include "utils/run_test_simulator.hpp"

int main(int argc, char** argv) {
    return run_test_simulator_cli(argc, argv);
}
