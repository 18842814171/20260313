//inst_name.hpp
/*#pragma once
#include <cstdint>
#include "decode.hpp"   // or encoding.hpp

inline const char* inst_name(uint32_t id)
{
    switch(id)
    {
        case make_inst_id(0x33,0,0): return "ADD";
        case make_inst_id(0x33,0,0x20): return "SUB";
        default: return "UNKNOWN";
    }
}