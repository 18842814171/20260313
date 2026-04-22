#ifndef RUN_TEST_SIMULATOR_HPP
#define RUN_TEST_SIMULATOR_HPP

#include "simulator.hpp"
#include "utils/utils.hpp"
#include <cstring>
#include <iostream>
#include <string>

/** 解析 --debug=0 / --debug=1，写入 sim_debug_runtime_enabled()。 */
inline void apply_debug_cli_flags(int argc, char** argv) {
    constexpr const char kPrefix[] = "--debug=";
    const size_t plen = sizeof(kPrefix) - 1;
    for (int i = 1; i < argc; ++i) {
        std::string a(argv[i]);
        if (a.size() <= plen || a.compare(0, plen, kPrefix) != 0)
            continue;
        std::string val = a.substr(plen);
        if (val == "0")
            sim_debug_runtime_enabled() = false;
        else if (val == "1")
            sim_debug_runtime_enabled() = true;
        else
            std::cerr << "警告: " << a << " 无效，请使用 --debug=0 或 --debug=1\n";
    }
}

inline bool arg_is_cli_flag(const char* s) {
    return s && std::strncmp(s, "--", 2) == 0;
}

/** 在 argv[from..argc) 中取第一个可解析的正整数为 max_steps（跳过 -- 开头项）。 */
inline size_t parse_max_steps_from_argv(int argc, char** argv, int from) {
    for (int i = from; i < argc; ++i) {
        if (arg_is_cli_flag(argv[i]))
            continue;
        try {
            unsigned long long v = std::stoull(argv[i]);
            if (v == 0) {
                std::cerr << "max_steps 须为正整数，已忽略: " << argv[i] << "\n";
                continue;
            }
            return static_cast<size_t>(v);
        } catch (...) {
            continue;
        }
    }
    return 0;
}

/** 测试入口：LogRedirector 写 log/ 下文件，并抑制 UART MMIO 的调试行（见 SimLogConfig）。 */
inline int run_test_simulator_cli(int argc, char** argv) {
    if (argc < 2) {
        std::cout << "用法: " << argv[0] << " <elf> [max_steps] [--debug=0|1]\n"
                  << "  max_steps 为正整数可选；可与 --debug 混排。\n"
                  << "  --debug=0  安静模式：不写 log/ 文件、不输出 LOG/调试类信息（stderr 仅保留告警/错误）。\n"
                  << "  --debug=1  显式开启调试输出（默认即为开启）。\n"
                 
                  << "  -h, --help  显示本帮助\n";
        return 1;
    }

    apply_debug_cli_flags(argc, argv);

    std::string a1(argv[1]);
    if (a1 == "-h" || a1 == "--help") {
        std::cout << "用法: " << argv[0] << " <elf> [max_steps] [--debug=0|1]\n";
        return 0;
    }

    std::string elf;
    size_t max_steps = 0;

   
    elf = a1;
    max_steps = parse_max_steps_from_argv(argc, argv, 2);
    

    if (sim_debug_runtime_enabled()) {
        LogRedirector log;
        if (log.start(elf)) {
            simulator(elf, max_steps);
            log.stop();
        } else {
            std::cerr << "警告: 无法打开日志文件，仅输出到终端。\n";
            simulator(elf, max_steps);
        }
    } else {
        simulator(elf, max_steps);
    }
    return 0;
}

#endif
