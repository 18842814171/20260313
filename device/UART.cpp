// device/UART.cpp
#include "device/UART.hpp"
#include "utils/utils.hpp"
#include <iostream>
#include <unistd.h>
#include <sys/types.h>
#include <sys/uio.h>

UART::UART()
    : txctrl(0), rxctrl(0), ie(0), ip(0), div(0) {
}

void UART::reset() {
    std::lock_guard<std::mutex> lock(mutex_);
    txctrl = 0;
    rxctrl = 0;
    ie = 0;
    ip = 0;
    div = 0;
    while (!rx_fifo.empty()) {
        rx_fifo.pop();
    }
}

void UART::write(uint32_t addr, uint8_t* data, size_t size) {
    if (size != 4) return;

    uint32_t value = bytes_to_word(data);

    switch (addr) {
        case REG_TXDATA: {
            uint8_t ch = value & TXDATA_DATA_MASK;
            if (is_tx_enabled()) {
                putchar(ch);
                fflush(stdout);
            }
            break;
        }
        case REG_TXCTRL:
            txctrl = value & (TXCTRL_TXEN_MASK | TXCTRL_TXWM_MASK);
            LOG("UART TXCTRL = 0x" + HEX(txctrl));
            break;
        case REG_RXCTRL:
            rxctrl = value & (RXCTRL_RXEN_MASK | RXCTRL_RXWM_MASK);
            LOG("UART RXCTRL = 0x" + HEX(rxctrl));
            break;
        case REG_IE:
            ie = value & (INT_TXWM_MASK | INT_RXWM_MASK);
            LOG("UART IE = 0x" + HEX(ie));
            break;
        case REG_IP:
            ip &= ~(value & (INT_TXWM_MASK | INT_RXWM_MASK));
            break;
        case REG_DIV:
            div = value;
            LOG("UART DIV = 0x" + HEX(div));
            break;
        default:
            LOG("UART write: unknown addr 0x" + HEX(addr));
            break;
    }
}

void UART::read(uint32_t addr, uint8_t* data, size_t size) {
    if (size != 4) return;

    uint32_t value = 0;

    switch (addr) {
        case REG_TXDATA:
            value = is_tx_full() ? TXDATA_FULL_MASK : 0;
            break;
        case REG_RXDATA: {
            std::lock_guard<std::mutex> lock(mutex_);
            if (!rx_fifo.empty()) {
                value = rx_fifo.front();
                rx_fifo.pop();
                clear_rx_interrupt();
            } else {
                value = RXDATA_EMPTY_MASK;
            }
            break;
        }
        case REG_TXCTRL:
            value = txctrl;
            break;
        case REG_RXCTRL:
            value = rxctrl;
            break;
        case REG_IE:
            value = ie;
            break;
        case REG_IP:
            value = ip;
            break;
        case REG_DIV:
            value = div;
            break;
        default:
            LOG("UART read: unknown addr 0x" + HEX(addr));
            value = 0;
            break;
    }

    word_to_bytes(value, data);
}

void UART::tick() {
    // UART 不需要在 tick 中做任何事，I/O 是按需处理的
}

bool UART::check_interrupt() {
    bool rx_irq_pending = (ip & INT_RXWM_MASK) && (ie & INT_RXWM_MASK);
    bool tx_irq_pending = (ip & INT_TXWM_MASK) && (ie & INT_TXWM_MASK);
    return rx_irq_pending || tx_irq_pending;
}

void UART::clear_interrupt() {
    ip = 0;
}

void UART::put_char(uint8_t c) {
    std::lock_guard<std::mutex> lock(mutex_);
    if (rx_fifo.size() < FIFO_SIZE) {
        rx_fifo.push(c);
        update_rx_interrupt();
    }
}

bool UART::get_char(uint8_t& c) {
    std::lock_guard<std::mutex> lock(mutex_);
    if (!rx_fifo.empty()) {
        c = rx_fifo.front();
        rx_fifo.pop();
        clear_rx_interrupt();
        return true;
    }
    return false;
}

size_t UART::rx_count() const {
    std::lock_guard<std::mutex> lock(const_cast<std::mutex&>(mutex_));
    return rx_fifo.size();
}

bool UART::has_received() const {
    std::lock_guard<std::mutex> lock(const_cast<std::mutex&>(mutex_));
    return !rx_fifo.empty();
}
