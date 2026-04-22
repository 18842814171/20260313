// Interrupt.cpp
#include "Interrupt.hpp"
#include "utils/utils.hpp"
#include <iostream>
#include <cstring>
#include <unistd.h>
#include <sys/time.h>

#define INTERRUPT_LOG(msg)                                                         \
    do {                                                                           \
        if (sim_debug_runtime_enabled()) {                                         \
            std::cout << "[Interrupt] " << msg << std::endl;                       \
        }                                                                          \
    } while (0)

InterruptController::InterruptController()
    : mie(false), mstatus_mie(false), mtvec(MTVEC_BASE),
      cycle_count(0), mie_reg(0), mip_reg(0), mcause(0) {
    for (int i = 0; i < 3; ++i) {
        interrupt_enabled[i] = false;
    }
}

void InterruptController::request_interrupt(InterruptType type, uint32_t source) {
    int idx = static_cast<int>(type);
    if (idx >= 3) return;

    if (type == InterruptType::EXTERNAL && ext_request_queued_) {
        return;
    }
    if (type == InterruptType::EXTERNAL) {
        ext_request_queued_ = true;
    }

    pending_interrupts.emplace(type, source, cycle_count);
    mip_reg |= (1 << idx);

    INTERRUPT_LOG("IRQ pending: type=" << idx << " source=" << source << " @ cycle " << cycle_count);
}

bool InterruptController::has_pending_interrupt() const {
    if (!mie || !mstatus_mie) return false;
    return !pending_interrupts.empty();
}

InterruptRequest InterruptController::get_pending_interrupt() {
    if (!has_pending_interrupt()) {
        return InterruptRequest(InterruptType::SOFTWARE, 0, cycle_count);
    }
    InterruptRequest irq = pending_interrupts.front();
    pending_interrupts.pop();

    if (irq.type == InterruptType::EXTERNAL) {
        ext_request_queued_ = false;
    }

    int idx = static_cast<int>(irq.type);
    if (idx >= 0 && idx < 3 && !interrupt_enabled[idx]) {
        if (!pending_interrupts.empty()) {
            return get_pending_interrupt();
        }
        return InterruptRequest(InterruptType::SOFTWARE, 0, cycle_count);
    }

    mip_reg &= ~(1 << static_cast<int>(irq.type));
    return irq;
}

void InterruptController::clear_interrupt() {
}

void InterruptController::enable_interrupt(InterruptType type) {
    int idx = static_cast<int>(type);
    if (idx >= 0 && idx < 3) {
        interrupt_enabled[idx] = true;
        mie_reg |= (1 << idx);
    }
}

void InterruptController::disable_interrupt(InterruptType type) {
    int idx = static_cast<int>(type);
    if (idx >= 0 && idx < 3) {
        interrupt_enabled[idx] = false;
        mie_reg &= ~(1 << idx);
    }
}

bool InterruptController::is_interrupt_enabled(InterruptType type) const {
    int idx = static_cast<int>(type);
    if (idx >= 0 && idx < 3) {
        return interrupt_enabled[idx] && mie && mstatus_mie;
    }
    return false;
}

uint32_t InterruptController::read_csr(uint32_t addr) const {
    switch (addr) {
        case 0x300: return mstatus | (mstatus_mie ? 0x8 : 0);
        case 0x304: return mie_reg;
        case 0x344: return mip_reg;
        case 0x342: return mcause;
        default: return 0;
    }
}

void InterruptController::write_csr(uint32_t addr, uint32_t value) {
    switch (addr) {
        case 0x300:
            mstatus_mie = (value & 0x8) != 0;
            mstatus = value & ~0x8;
            break;
        case 0x304:
            mie_reg = value;
            mie = (value & 0x8) != 0;
            break;
        case 0x344:
            mip_reg = value;
            break;
        default:
            break;
    }
}

void InterruptController::tick() {
    cycle_count++;
}

// TrapHandler implementation

TrapHandler::TrapHandler()
    : trapping(false), mepc(0), mcause(0),
      mtval(0), mstatus(0), mtvec(0x100), mode(PrivilegeMode::MACHINE) {}

void TrapHandler::enter_trap(bool is_interrupt, uint32_t cause, uint32_t epc) {
    trapping = true;
    mepc = epc;
    mcause = is_interrupt ? (0x80000000 | cause) : cause;
    mtval = 0;

    uint32_t trap_vec = mtvec;
    if (is_interrupt && (mtvec & 0x2) == 0) {
        trap_vec = mtvec + (cause * 4);
    } else if (is_interrupt) {
        trap_vec = (mtvec & ~0x3) + cause;
    }

    mstatus &= ~0x8;
    mstatus |= (static_cast<uint32_t>(mode) << 11);

    INTERRUPT_LOG("TRAP: enter is_interrupt=" << is_interrupt
          << " cause=0x" << std::hex << cause
          << " epc=0x" << mepc << " vec=0x" << trap_vec);
}

void TrapHandler::exit_trap() {
    if (!trapping) return;
    trapping = false;
    mstatus |= 0x8;
    INTERRUPT_LOG("TRAP: exit to epc=0x" << std::hex << mepc);
}