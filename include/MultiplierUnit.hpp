#pragma once

#include <cstdint>

/**
 * 多周期整数乘法单元（与 ALU 分离）。
 *
 * 当前实现是“单发射、固定延迟、结果缓冲”的简化流水乘法器：
 * - issue 后不阻塞整个 EX，普通 ALU 指令仍可继续流过
 * - 结果 ready 后会先停留在内部 result latch，等待 CPU 在某个周期取走
 * - 由于没有 ROB，这里只允许一条乘法在 flight，靠 scoreboarding 阻止 RAW/WAW
 */
class MultiplierUnit {
public:
    /// 从 issue 到结果 ready 的固定延迟。
    static constexpr int kLatency = 4;

    void reset() {
        in_flight_ = false;
        result_ready_ = false;
        cycles_left_ = 0;
        a_ = b_ = 0;
        rd_ = pc_ = 0;
        result_ = 0;
    }

    bool busy() const { return in_flight_; }
    bool can_issue() const { return !in_flight_; }
    bool has_pending_write() const { return in_flight_ || result_ready_; }
    bool result_ready() const { return result_ready_; }
    uint32_t pending_rd() const { return rd_; }

    void issue(uint32_t a, uint32_t b, uint32_t rd, uint32_t pc) {
        in_flight_ = true;
        result_ready_ = false;
        cycles_left_ = kLatency - 1;
        a_ = a;
        b_ = b;
        rd_ = rd;
        pc_ = pc;
    }

    void cancel() { reset(); }

    /// 每周期推进一次内部流水线。ready 结果会停在内部 latch，直到被 consume。
    void tick() {
        if (!in_flight_) {
            return;
        }
        if (cycles_left_ > 0) {
            cycles_left_--;
            return;
        }
        result_ = static_cast<uint32_t>(static_cast<uint64_t>(a_) * static_cast<uint64_t>(b_));
        in_flight_ = false;
        result_ready_ = true;
        cycles_left_ = 0;
    }

    void consume_result(uint32_t& out_rd, uint32_t& out_pc, uint32_t& out_prod) {
        out_rd = rd_;
        out_pc = pc_;
        out_prod = result_;
        result_ready_ = false;
    }

private:
    bool in_flight_ = false;
    bool result_ready_ = false;
    int cycles_left_ = 0;
    uint32_t a_ = 0;
    uint32_t b_ = 0;
    uint32_t rd_ = 0;
    uint32_t pc_ = 0;
    uint32_t result_ = 0;
};
