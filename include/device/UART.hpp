#ifndef UART_HPP
#define UART_HPP

#include "Device.hpp"
#include <cstdint>
#include <queue>
#include <mutex>

class UART : public Device {
private:
    // UART 寄存器偏移量 (相对于基地址)
    static constexpr uint32_t REG_TXDATA   = 0x00;  // 发送数据寄存器 (只写)
    static constexpr uint32_t REG_RXDATA   = 0x04;  // 接收数据寄存器 (只读)
    static constexpr uint32_t REG_TXCTRL   = 0x08;  // 发送控制寄存器
    static constexpr uint32_t REG_RXCTRL   = 0x0C;  // 接收控制寄存器
    static constexpr uint32_t REG_IE       = 0x10;  // 中断使能寄存器
    static constexpr uint32_t REG_IP       = 0x14;  // 中断挂起寄存器
    static constexpr uint32_t REG_DIV      = 0x18;  // 波特率分频寄存器

    // TXDATA 寄存器位定义
    static constexpr uint32_t TXDATA_DATA_MASK  = 0xFF;
    static constexpr uint32_t TXDATA_FULL_MASK  = 0x80000000;

    // RXDATA 寄存器位定义
    static constexpr uint32_t RXDATA_DATA_MASK  = 0xFF;
    static constexpr uint32_t RXDATA_EMPTY_MASK = 0x80000000;

    // TXCTRL 寄存器位定义
    static constexpr uint32_t TXCTRL_TXEN_MASK  = 0x1;
    static constexpr uint32_t TXCTRL_TXWM_MASK   = 0x2;  // 发送水印中断

    // RXCTRL 寄存器位定义
    static constexpr uint32_t RXCTRL_RXEN_MASK  = 0x1;
    static constexpr uint32_t RXCTRL_RXWM_MASK  = 0x2;  // 接收水印中断

    // IE/IP 寄存器位定义
    static constexpr uint32_t INT_TXWM_MASK = 0x1;  // 发送水印中断
    static constexpr uint32_t INT_RXWM_MASK = 0x2;  // 接收水印中断

    // 寄存器变量
    uint32_t txctrl;      // 发送控制
    uint32_t rxctrl;      // 接收控制
    uint32_t ie;          // 中断使能
    uint32_t ip;          // 中断挂起
    uint32_t div;         // 波特率分频

    // FIFO 缓冲区
    std::queue<uint8_t> rx_fifo;
    static constexpr size_t FIFO_SIZE = 16;

    // 互斥锁用于线程安全
    mutable std::mutex mutex_;

    // 内部辅助方法
    bool is_tx_enabled() const { return txctrl & TXCTRL_TXEN_MASK; }
    bool is_rx_enabled() const { return rxctrl & RXCTRL_RXEN_MASK; }

    void update_rx_interrupt() {
        if (rx_fifo.size() > 0) {
            ip |= INT_RXWM_MASK;
        }
    }

    void clear_rx_interrupt() {
        ip &= ~INT_RXWM_MASK;
    }

public:
    UART();
    void reset();

    // Device interface
    void write(uint32_t addr, uint8_t* data, size_t size) override;
    void read(uint32_t addr, uint8_t* data, size_t size) override;

    // UART 操作
    void tick();
    bool check_interrupt();
    void clear_interrupt();

    // 外部输入数据接口 (用于测试或仿真)
    void put_char(uint8_t c);
    bool get_char(uint8_t& c);
    bool has_received() const;

    // 状态查询
    bool is_tx_full() const { return false; }  // TX FIFO 总是可用
    size_t rx_count() const;

    // Getter 方法
    uint32_t get_txctrl() const { return txctrl; }
    uint32_t get_rxctrl() const { return rxctrl; }
    uint32_t get_ie() const { return ie; }
    uint32_t get_ip() const { return ip; }
    uint32_t get_div() const { return div; }

};

#endif // UART_HPP