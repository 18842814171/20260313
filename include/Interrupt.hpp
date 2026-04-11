#ifndef INTERRUPT_HPP
#define INTERRUPT_HPP

#include <cstdint>
#include <functional>
#include <vector>
#include <queue>

enum class InterruptType : uint8_t {
    TIMER = 0,
    EXTERNAL = 1,
    SOFTWARE = 2,
    SYSCALL = 3,
};

enum class PrivilegeMode : uint8_t {
    USER = 0,
    SUPERVISOR = 1,
    MACHINE = 3,
};

struct InterruptRequest {
    InterruptType type;
    uint32_t source;
    uint32_t timestamp;
    bool pending;

    InterruptRequest(InterruptType t, uint32_t src, uint32_t ts)
        : type(t), source(src), timestamp(ts), pending(true) {}
};

class InterruptController {
public:
    static constexpr uint32_t MTVEC_BASE = 0x100;
    static constexpr uint32_t MSTATUS_ADDR = 0x300;
    static constexpr uint32_t MIE_ADDR = 0x304;
    static constexpr uint32_t MIP_ADDR = 0x344;
    static constexpr uint32_t MCAUSE_ADDR = 0x342;

    InterruptController();

    void request_interrupt(InterruptType type, uint32_t source = 0);
    bool has_pending_interrupt() const;
    InterruptRequest get_pending_interrupt();
    void clear_interrupt();

    void set_mie(bool enable) { mie = enable; }
    bool get_mie() const { return mie; }

    void set_mtvec(uint32_t addr) { mtvec = addr; }
    uint32_t get_mtvec() const { return mtvec; }

    void set_mstatus_mie(bool enable) { mstatus_mie = enable; }
    bool get_mstatus_mie() const { return mstatus_mie; }

    void enable_interrupt(InterruptType type);
    void disable_interrupt(InterruptType type);
    bool is_interrupt_enabled(InterruptType type) const;

    uint32_t read_csr(uint32_t addr) const;
    void write_csr(uint32_t addr, uint32_t value);

    void tick();

private:
    bool mie;
    bool mstatus_mie;
    uint32_t mtvec;
    uint32_t mstatus;
    bool interrupt_enabled[3];
    std::queue<InterruptRequest> pending_interrupts;
    uint32_t cycle_count;
    uint32_t mie_reg;
    uint32_t mip_reg;
    uint32_t mcause;
};

class TrapHandler {
public:
    TrapHandler();

    void enter_trap(bool is_interrupt, uint32_t cause, uint32_t epc);
    void exit_trap();

    uint32_t get_epc() const { return mepc; }
    uint32_t get_cause() const { return mcause; }
    bool is_trapping() const { return trapping; }

    void set_mstatus(uint32_t val) { mstatus = val; }
    uint32_t get_mstatus() const { return mstatus; }
    uint32_t get_mtval() const { return mtval; }
    uint32_t get_mtvec() const { return mtvec; }
    void set_mtvec(uint32_t addr) { mtvec = addr; }

private:
    bool trapping;
    uint32_t mepc;
    uint32_t mcause;
    uint32_t mtval;
    uint32_t mstatus;
    uint32_t mtvec;
    PrivilegeMode mode;
};

#endif