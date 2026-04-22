#pragma once
#ifndef CPU_HPP
#define CPU_HPP
// include/cpu.hpp
#include <cstdint>
#include <cstdio>
#include <iosfwd>
#include <string>
#include "Pipe.hpp"
#include "Interrupt.hpp"
class Memory;
class InstManager;
class Bus;
class UART;

class Inst;
#include "utils/utils.hpp"

class CPU {
public:
    /** max_steps==0 时使用的默认周期上限（防死循环刷日志） */
    static constexpr size_t kDefaultRunStepLimit = 10'000'000;
    /** 用户显式传入 max_steps 时的绝对硬顶（防误传天文数字） */
    static constexpr size_t kHardAbsoluteRunStepLimit = 100'000'000;

    Pipe_IF_ID if_id;
    Pipe_ID_EX id_ex;
    Pipe_EX_MEM ex_mem;
    Pipe_MEM_WB mem_wb;
    uint32_t reg[32]{};
    uint32_t pc = 0x10000;
    bool pc_modified = false;
    bool halt = false;
    int exit_code = 0;
    bool stall=false;
    size_t step_count = 0;

    // Last memory access info (for interactive frontends)
    bool last_mem_valid = false;
    bool last_mem_is_read = false;
    uint32_t last_mem_addr = 0;
    uint32_t last_mem_read_data = 0;
    
    CPU(Memory& mem_ref, InstManager& im_ref); 
    ~CPU();

    //Pipeline stages
    void fetch(Pipe_IF_ID& out);
    void decode(Pipe_IF_ID& in, Pipe_ID_EX& out);
    void execute(Pipe_ID_EX& in, const Pipe_EX_MEM& prev_ex_mem, Pipe_EX_MEM& out);
    void memory_access(Pipe_EX_MEM& in, Pipe_MEM_WB& out);
    void writeback(Pipe_MEM_WB& in);

    bool step();//single cycle
    void run(size_t max_steps = 0);//multiple cycles

    /** 推进 Timer / UART 并投递 IRQ（不取指、不写回），供 WFI 与外设同步。 */
    void tick_mmio_and_irq_sources();

    void set_pc(uint32_t new_pc) { pc = new_pc; }
    void dump_registers() const; 
    //void dump_state(const std::string& prefix = "") const; 
    std::string get_inst_name(uint32_t opcode) const;
    //uint32_t calc_addr(const CPU& cpu, Inst inst) const;
    void dump_pipeline_state() const;
    // Interrupt and Syscall support
    Memory& get_memory() { return memory; }
    void attach_bus(Bus* b) { bus = b; }
    Bus* get_bus() { return bus; }
    
    void enable_interrupts() { 
        interrupt_enabled = true; 
        LOG("Interrupts enabled");
    }
    void disable_interrupts() { 
        interrupt_enabled = false; 
        LOG("Interrupts disabled");
    }
    bool interrupts_enabled() const { return interrupt_enabled; }
    
    bool is_trapping() const { return trap_handler && trap_handler->is_trapping(); }
    void enter_trap(bool is_interrupt, uint32_t cause) {
        if (trap_handler) {
            trap_handler->enter_trap(is_interrupt, cause, pc - 4);
            if_id.valid = false;
            id_ex.valid = false;
            ex_mem.valid = false;
        }
    }
    void exit_trap() {
        if (trap_handler) {
            trap_handler->exit_trap();
            pc = trap_handler->get_epc();
        }
    }
    
    void request_interrupt(InterruptType type, uint32_t source = 0) {
        if (int_ctrl) {
            int_ctrl->request_interrupt(type, source);
        }
    }
    
    void set_trap_handler(TrapHandler* handler) { trap_handler = handler; }
    void set_interrupt_controller(InterruptController* ctrl) { int_ctrl = ctrl; }
    InterruptController* get_interrupt_controller() { return int_ctrl; }

    // UART for stdin simulation
    void attach_uart(UART* u) { uart = u; }
    UART* get_uart() const { return uart; }

    void reset_instruction_statistics();
    void dump_instruction_statistics(std::ostream& os) const;

private:
    Memory& memory;
    InstManager& inst_manager;
    Bus* bus = nullptr;
    UART* uart = nullptr;
    uint32_t read_reg_forwarded(unsigned r) const;

    bool interrupt_enabled = false;
    InterruptController* int_ctrl = nullptr;
    TrapHandler* trap_handler = nullptr;

    uint64_t gpr_read_count_[32]{};
    uint64_t gpr_write_count_[32]{};
};
#endif