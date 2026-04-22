#include "Device.hpp"
class Memory : public Device {
    private:
        static constexpr uint32_t MEM_SIZE = 1024 * 256 * 4;  // 256KB
        static constexpr uint32_t BASE = 0x10000;
        uint32_t mem[MEM_SIZE];
        /** 曾写入过的最高字节地址（含）；0 表示尚未在主存区内写入 */
        uint32_t high_water_byte_addr_ = 0;
        void note_write(uint32_t addr, size_t nbytes);
    
    public:
        Memory();
        
        void write(uint32_t addr, uint8_t* data, size_t size) override;
        void read(uint32_t addr, uint8_t* data, size_t size) override;
        uint8_t read_byte(uint32_t addr);
        void    write_byte(uint32_t addr, uint8_t value);
        uint32_t read_word(uint32_t addr);
        void write_word(uint32_t addr, uint32_t value);
        bool is_valid(uint32_t addr) const;

        static constexpr uint32_t base_address() { return BASE; }
        static constexpr size_t capacity_bytes() { return static_cast<size_t>(MEM_SIZE) * 4u; }
        /** 主存区内已触及的最高地址；若无写入则返回 0 */
        uint32_t high_water_byte_address() const { return high_water_byte_addr_; }
    };
    