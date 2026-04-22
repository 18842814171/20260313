// device/UART.cpp
#include "device/UART.hpp"
#include "utils/utils.hpp"
#include <chrono>
#include <cerrno>
#include <fcntl.h>
#include <iostream>
#include <mutex>
#include <thread>
#include <unistd.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <termios.h>

#if DEBUG == 1
#define UART_DEV_LOG(msg)                                                              \
    do {                                                                               \
        if (!SimLogConfig::suppress_uart_mmio_logs) {                                  \
            LOG(msg);                                                                  \
        }                                                                              \
    } while (0)
#else
#define UART_DEV_LOG(msg) ((void)0)
#endif

UART::UART()
    : txctrl(TXCTRL_TXEN_MASK),
      rxctrl(RXCTRL_RXEN_MASK | RXCTRL_RXWM_MASK),
      ie(INT_RXWM_MASK),
      ip(0),
      div(0) {
}

UART::~UART() {
    stop_console_input();
}

void UART::reset() {
    std::lock_guard<std::mutex> lock(mutex_);
    // Default-on UART so tests don't need to repeatedly program control registers.
    txctrl = TXCTRL_TXEN_MASK;
    rxctrl = RXCTRL_RXEN_MASK | RXCTRL_RXWM_MASK;
    ie = INT_RXWM_MASK;
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
                tx_char_total_.fetch_add(1, std::memory_order_relaxed);
            }
            break;
        }
        case REG_TXCTRL:
            txctrl = value & (TXCTRL_TXEN_MASK | TXCTRL_TXWM_MASK);
            UART_DEV_LOG("UART TXCTRL = 0x" + HEX(txctrl));
            break;
        case REG_RXCTRL:
            rxctrl = value & (RXCTRL_RXEN_MASK | RXCTRL_RXWM_MASK);
            UART_DEV_LOG("UART RXCTRL = 0x" + HEX(rxctrl));
            break;
        case REG_IE:
            ie = value & (INT_TXWM_MASK | INT_RXWM_MASK);
            UART_DEV_LOG("UART IE = 0x" + HEX(ie));
            break;
        case REG_IP:
            ip &= ~(value & (INT_TXWM_MASK | INT_RXWM_MASK));
            break;
        case REG_DIV:
            div = value;
            UART_DEV_LOG("UART DIV = 0x" + HEX(div));
            break;
        default:
            UART_DEV_LOG("UART write: unknown addr 0x" + HEX(addr));
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
                rx_char_total_.fetch_add(1, std::memory_order_relaxed);
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
            UART_DEV_LOG("UART read: unknown addr 0x" + HEX(addr));
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
    for (;;) {
        std::unique_lock<std::mutex> lock(mutex_);
        if (rx_fifo.size() < FIFO_SIZE) {
            rx_fifo.push(c);
            update_rx_interrupt();
            return;
        }
        lock.unlock();
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
    }
}

bool UART::get_char(uint8_t& c) {
    std::lock_guard<std::mutex> lock(mutex_);
    if (!rx_fifo.empty()) {
        c = rx_fifo.front();
        rx_fifo.pop();
        clear_rx_interrupt();
        rx_char_total_.fetch_add(1, std::memory_order_relaxed);
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

bool UART::try_pop_syscall_byte(uint8_t& c) {
    std::lock_guard<std::mutex> lock(mutex_);
    if (rx_fifo.empty()) {
        return false;
    }
    c = rx_fifo.front();
    rx_fifo.pop();
    update_rx_interrupt();
    rx_char_total_.fetch_add(1, std::memory_order_relaxed);
    return true;
}

void UART::reset_transfer_counters() {
    tx_char_total_.store(0, std::memory_order_relaxed);
    rx_char_total_.store(0, std::memory_order_relaxed);
}

void UART::console_set_raw_mode() {
    struct termios ttystate;
    if (tcgetattr(console_stdin_fd_, &ttystate) != 0) {
        return;
    }
    ttystate.c_lflag &= ~(ICANON | ECHO);
    ttystate.c_cc[VMIN] = 0;
    ttystate.c_cc[VTIME] = 0;
    tcsetattr(console_stdin_fd_, TCSANOW, &ttystate);
}

void UART::console_restore_terminal() {
    struct termios ttystate;
    if (tcgetattr(console_stdin_fd_, &ttystate) != 0) {
        return;
    }
    ttystate.c_lflag |= ICANON | ECHO;
    tcsetattr(console_stdin_fd_, TCSANOW, &ttystate);
}

void UART::console_input_loop() {
    console_set_raw_mode();
    while (console_running_) {
        char c = 0;
        ssize_t n = ::read(console_stdin_fd_, &c, 1);
        if (n > 0) {
            if (c == 3) {
                console_running_ = false;
                break;
            }
            if (c == '\r') {
                put_char(static_cast<uint8_t>('\n'));
            } else {
                put_char(static_cast<uint8_t>(c));
            }
        } else if (n < 0 && (errno == EAGAIN || errno == EWOULDBLOCK)) {
            std::this_thread::sleep_for(std::chrono::milliseconds(5));
        } else {
            std::this_thread::sleep_for(std::chrono::milliseconds(5));
        }
    }
    console_restore_terminal();
}

void UART::start_console_input(int stdin_fd) {
    if (console_running_) {
        return;
    }
    console_stdin_fd_ = stdin_fd;
    console_stdin_saved_flags_ = fcntl(console_stdin_fd_, F_GETFL, 0);
    if (console_stdin_saved_flags_ >= 0) {
        fcntl(console_stdin_fd_, F_SETFL, console_stdin_saved_flags_ | O_NONBLOCK);
    }
    console_running_ = true;
    console_thread_ = std::thread(&UART::console_input_loop, this);
}

void UART::stop_console_input() {
    console_running_ = false;
    if (console_thread_.joinable()) {
        console_thread_.join();
    }
    if (console_stdin_saved_flags_ >= 0) {
        fcntl(console_stdin_fd_, F_SETFL, console_stdin_saved_flags_);
        console_stdin_saved_flags_ = -1;
    }
}
