#ifndef COLOR_SCHEMA_HPP
#define COLOR_SCHEMA_HPP

#include <cstdint>

struct ColorRGB {
    uint8_t r = 0;
    uint8_t g = 0;
    uint8_t b = 0;
};

enum class ColorFormat : uint32_t {
    GRAY8 = 0u,
    RGB332 = 1u
};

inline uint8_t encode_rgb332(const ColorRGB& c) {
    const uint8_t r3 = static_cast<uint8_t>((static_cast<uint16_t>(c.r) * 7u) / 255u);
    const uint8_t g3 = static_cast<uint8_t>((static_cast<uint16_t>(c.g) * 7u) / 255u);
    const uint8_t b2 = static_cast<uint8_t>((static_cast<uint16_t>(c.b) * 3u) / 255u);
    return static_cast<uint8_t>((r3 << 5) | (g3 << 2) | b2);
}

inline uint8_t encode_gray8(const ColorRGB& c) {
    const uint16_t y = static_cast<uint16_t>(77u * c.r + 150u * c.g + 29u * c.b);
    return static_cast<uint8_t>(y >> 8);
}

#endif
