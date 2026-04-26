//simulator.cpp
#include "simulator.hpp"
#include "utils/utils.hpp"
#include "Instmngr.hpp"
#include "CPU.hpp"
#include "device/Device.hpp"
#include "device/Bus.hpp"
#include "device/Timer.hpp"
#include "device/UART.hpp"
#include "device/Display.hpp"
#include "Decoder.hpp"
#include "Loader.hpp"
#include "maploader.hpp"
#include "Interrupt.hpp"
#include "SimulatorAPI.hpp"
#include "inst/arithm.hpp"
#include "inst/load_store.hpp"
#include "inst/auipc.hpp"
#include "inst/branch.hpp"
#include "inst/jump.hpp"
#include "inst/system.hpp"
#include "inst/lui.hpp"

#include <iomanip>
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <string>
#include <tuple>
#include <unistd.h>

extern void register_all_instructions(InstManager *im);
namespace {
constexpr uint32_t kDispBase = 0x10001000u;
constexpr uint32_t kDispCtrl = 0x00u;
constexpr uint32_t kDispFbAddr = 0x08u;
constexpr uint32_t kDispWidth = 0x0Cu;
constexpr uint32_t kDispHeight = 0x10u;
constexpr uint32_t kDispFormat = 0x14u;
constexpr uint32_t kDispCtrlEnable = 1u << 0;
constexpr uint32_t kDispCtrlRefresh = 1u << 1;
constexpr uint32_t kDefaultFbAddr = 0x30000u;

void preload_display_map_if_requested(const std::string& map_json_path, Memory& mem, Bus& bus) {
    if (map_json_path.empty()) {
        return;
    }
    MapImage image = load_map_from_json_file(map_json_path);
    if (image.pixels.empty()) {
        throw std::runtime_error("Map image has no pixels: " + map_json_path);
    }

    const uint32_t fb_addr = kDefaultFbAddr;
    for (size_t i = 0; i < image.pixels.size(); ++i) {
        mem.write_byte(fb_addr + static_cast<uint32_t>(i), image.pixels[i]);
    }

    bus.write_word(kDispBase + kDispFbAddr, fb_addr);
    bus.write_word(kDispBase + kDispWidth, image.width);
    bus.write_word(kDispBase + kDispHeight, image.height);
    bus.write_word(kDispBase + kDispFormat,
                   image.format == ColorFormat::RGB332 ? 1u : 0u);
    bus.write_word(kDispBase + kDispCtrl, kDispCtrlEnable | kDispCtrlRefresh);

    LOG("Display map preloaded from JSON: " + map_json_path +
        " (" + std::to_string(image.width) + "x" + std::to_string(image.height) + ")");
}
} // namespace

static void print_device_status(const char* title, Memory& mem, const CPU& cpu, const Timer& timer,
                                const UART& uart) {
    std::cerr << "\n=== " << title << " ===\n";
    std::cerr << "主存: 容量 " << Memory::capacity_bytes() << " bytes, 基址 0x"
              << std::hex << Memory::base_address() << std::dec << "\n";
    const uint32_t hw = mem.high_water_byte_address();
    if (hw == 0) {
        std::cerr << "      主存区内尚无写入记录(或仅 MMIO)\n";
    } else {
        std::cerr << "      已写入最高字节地址 0x" << std::hex << hw << std::dec
                  << " (相对基址 +" << (hw - Memory::base_address()) << " bytes)\n";
    }
    std::cerr << "Timer MTIME: " << timer.get_mtime() << "\n";
    std::cerr << "UART: TX 字符(送主机) " << uart.tx_character_count() << ", RX 字符(程序已读走) "
              << uart.rx_character_count() << ", 当前 RX FIFO " << uart.rx_count() << "\n";
    cpu.dump_instruction_statistics(std::cerr);
    std::cerr.flush();
}

void simulator(std::string infile, size_t max_steps, const std::string& map_json_path) {
    InstManager im;
    register_all_instructions(&im);

    Memory mem;
    CPU cpu(mem, im);

    static InterruptController int_ctrl;
    static TrapHandler trap;
    cpu.set_interrupt_controller(&int_ctrl);
    cpu.set_trap_handler(&trap);
    cpu.enable_interrupts();

    int_ctrl.set_mstatus_mie(true);
    int_ctrl.set_mie(true);
    int_ctrl.enable_interrupt(InterruptType::TIMER);
    int_ctrl.enable_interrupt(InterruptType::EXTERNAL);

    uint32_t entry_point = load_elf(infile, mem);
    uint32_t main_addr = get_symbol(infile, "main");
    uint32_t gp_val = get_symbol(infile, "__global_pointer$");

    LOG("Loading ELF: " + infile);
    LOG("Program entry point: 0x" + HEX(entry_point));
    LOG("Main address: 0x" + HEX(main_addr));
    if (gp_val) {
        LOG("GP initialized to 0x" + HEX(gp_val));
    }

    auto args = setup_args_for_elf(infile, 0x20000, mem);

    cpu.set_pc(entry_point);
    cpu.reg[0] = 0;
    cpu.reg[1] = 0xFFFFFFFF;
    cpu.reg[2] = args.sp;
    cpu.reg[3] = gp_val;
    cpu.reg[4] = 0;
    cpu.reg[10] = args.argc;
    cpu.reg[11] = args.argv_addr;
    cpu.reg[12] = 0;
    cpu.reg[17] = 0;

    Bus bus;
    bus.attach_memory(&mem);

    Timer timer;
    bus.attach_device(0x02004000, &timer);

    UART uart;
    bus.attach_device(0x10000000, &uart);

    DisplayDevice display(mem);
    bus.attach_device(0x10001000, &display);

    cpu.attach_bus(&bus);
    cpu.attach_uart(&uart);

    preload_display_map_if_requested(map_json_path, mem, bus);

    uart.reset_transfer_counters();
    cpu.reset_instruction_statistics();

    if (sim_debug_runtime_enabled()) {
        print_device_status("运行前（设备/内存/统计）", mem, cpu, timer, uart);

        std::cerr << "\n[UART: 主机键盘 → MMIO RX；Ctrl+C 结束 stdin 线程]\n";
        if (max_steps > 0) {
            std::cerr << "[模拟器] 本次步数上限(请求) " << max_steps << "，硬顶 CPU::kHardAbsoluteRunStepLimit="
                      << CPU::kHardAbsoluteRunStepLimit << "\n";
        } else {
            std::cerr << "[模拟器] 未指定步数上限，使用默认 CPU::kDefaultRunStepLimit=" << CPU::kDefaultRunStepLimit
                      << " 周期\n";
        }
    }

    uart.start_console_input(STDIN_FILENO);

    LOG("\n========== Running ==========");
    cpu.run(max_steps);

    uart.stop_console_input();

    if (sim_debug_runtime_enabled())
        print_device_status("运行后（设备/内存/统计）", mem, cpu, timer, uart);
    else {
        // 安静模式：不输出逐步调试/不写日志文件，但仍给出最终结果，方便判断是否正常 ECALL 退出。
        std::cerr << "[模拟器] 运行结束: halted=" << (cpu.halt ? 1 : 0)
                  << " steps=" << cpu.step_count
                  << " exit_code=" << cpu.exit_code
                  << " pc=0x" << std::hex << cpu.pc << std::dec << "\n";
    }

    LOG("\nRan " + std::to_string(cpu.step_count) + " steps.");
    LOG("PC: 0x" + HEX(cpu.pc));
    LOG("Exit code: " + std::to_string(cpu.exit_code));

    LOG("\n=== Final Register State ===");
    if (sim_debug_runtime_enabled())
        cpu.dump_registers();

    LOG("\n========== Final Status ==========");
    LOG("Timer MTIME: " + std::to_string(timer.get_mtime()));
    LOG("UART RX FIFO: " + std::to_string(uart.rx_count()) + " char(s)");
}
