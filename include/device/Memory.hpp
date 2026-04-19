#include "Device.hpp"
class Memory : public Device {
    private:
        static constexpr uint32_t MEM_SIZE = 1024 * 256 * 4;  // 256KB
        static constexpr uint32_t BASE = 0x10000;
        uint32_t mem[MEM_SIZE];
    
    public:
        Memory();
        
        void write(uint32_t addr, uint8_t* data, size_t size) override;
        void read(uint32_t addr, uint8_t* data, size_t size) override;
        uint8_t read_byte(uint32_t addr);
        void    write_byte(uint32_t addr, uint8_t value);
        uint32_t read_word(uint32_t addr);
        void write_word(uint32_t addr, uint32_t value);
        bool is_valid(uint32_t addr) const;
    };
    