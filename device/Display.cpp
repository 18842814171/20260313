#include "device/Display.hpp"
#include "device/Memory.hpp"
#include "utils/utils.hpp"
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <cctype>

DisplayDevice::DisplayDevice(Memory& mem) : memory_(mem) {}

void DisplayDevice::rgb332_to_rgb888(uint8_t p, uint8_t& r, uint8_t& g, uint8_t& b) {
    const uint8_t r3 = (p >> 5) & 0x07;
    const uint8_t g3 = (p >> 2) & 0x07;
    const uint8_t b2 = p & 0x03;
    r = static_cast<uint8_t>((r3 * 255u) / 7u);
    g = static_cast<uint8_t>((g3 * 255u) / 7u);
    b = static_cast<uint8_t>((b2 * 255u) / 3u);
}

std::string DisplayDevice::resolve_output_filename() const {
    if (out_name_len_ == 0 || out_name_addr_ == 0 || out_name_len_ > 120) {
        std::ostringstream fallback;
        fallback << "plot/display_frame_" << std::setw(6) << std::setfill('0') << frame_count_ << ".ppm";
        return fallback.str();
    }

    std::string name;
    name.reserve(out_name_len_);
    for (uint32_t i = 0; i < out_name_len_; ++i) {
        const uint32_t addr = out_name_addr_ + i;
        if (!memory_.is_valid(addr)) {
            break;
        }
        const char c = static_cast<char>(memory_.read_byte(addr));
        if (c == '\0') {
            break;
        }
        const bool ok =
            std::isalnum(static_cast<unsigned char>(c)) != 0 ||
            c == '_' || c == '-' || c == '.' || c == '/';
        if (!ok) {
            continue;
        }
        name.push_back(c);
    }

    if (name.empty()) {
        std::ostringstream fallback;
        fallback << "plot/display_frame_" << std::setw(6) << std::setfill('0') << frame_count_ << ".ppm";
        return fallback.str();
    }
    if (name.find('/') == std::string::npos) {
        name = "plot/" + name;
    }
    if (name.size() < 4 || name.substr(name.size() - 4) != ".ppm") {
        name += ".ppm";
    }
    return name;
}

void DisplayDevice::dump_frame_to_ppm() {
    if ((ctrl_ & CTRL_ENABLE) == 0) {
        return;
    }
    if (width_ == 0 || height_ == 0 || width_ > 1024 || height_ > 1024) {
        status_ |= STATUS_ERROR;
        return;
    }
    if (!memory_.is_valid(fb_addr_)) {
        status_ |= STATUS_ERROR;
        return;
    }

    const std::string filename = resolve_output_filename();
    const std::filesystem::path output_path(filename);
    if (!output_path.parent_path().empty()) {
        std::filesystem::create_directories(output_path.parent_path());
    }
    std::ofstream out(filename, std::ios::binary);
    if (!out.is_open()) {
        status_ |= STATUS_ERROR;
        return;
    }

    out << "P6\n" << width_ << " " << height_ << "\n255\n";
    const uint32_t pixels = width_ * height_;
    for (uint32_t i = 0; i < pixels; ++i) {
        const uint32_t addr = fb_addr_ + i;
        uint8_t src = memory_.is_valid(addr) ? memory_.read_byte(addr) : 0;
        uint8_t r = 0, g = 0, b = 0;
        if (format_ == FORMAT_RGB332) {
            rgb332_to_rgb888(src, r, g, b);
        } else {
            r = g = b = src;
        }
        out.put(static_cast<char>(r));
        out.put(static_cast<char>(g));
        out.put(static_cast<char>(b));
    }
    frame_count_++;
    status_ = STATUS_READY;
}

void DisplayDevice::write(uint32_t addr, uint8_t* data, size_t size) {
    if (size != 4) {
        return;
    }
    const uint32_t value = bytes_to_word(data);
    switch (addr) {
        case REG_CTRL:
            ctrl_ = value & (CTRL_ENABLE | CTRL_REFRESH);
            if (value & CTRL_REFRESH) {
                dump_frame_to_ppm();
                ctrl_ &= ~CTRL_REFRESH;
            }
            break;
        case REG_FB_ADDR:
            fb_addr_ = value;
            break;
        case REG_WIDTH:
            width_ = value;
            break;
        case REG_HEIGHT:
            height_ = value;
            break;
        case REG_FORMAT:
            format_ = value;
            break;
        case REG_OUT_NAME_ADDR:
            out_name_addr_ = value;
            break;
        case REG_OUT_NAME_LEN:
            out_name_len_ = value;
            break;
        default:
            break;
    }
}

void DisplayDevice::read(uint32_t addr, uint8_t* data, size_t size) {
    if (size != 4) {
        return;
    }
    uint32_t value = 0;
    switch (addr) {
        case REG_CTRL: value = ctrl_; break;
        case REG_STATUS: value = status_; break;
        case REG_FB_ADDR: value = fb_addr_; break;
        case REG_WIDTH: value = width_; break;
        case REG_HEIGHT: value = height_; break;
        case REG_FORMAT: value = format_; break;
        case REG_FRAME_COUNT: value = frame_count_; break;
        case REG_OUT_NAME_ADDR: value = out_name_addr_; break;
        case REG_OUT_NAME_LEN: value = out_name_len_; break;
        default: value = 0; break;
    }
    word_to_bytes(value, data);
}
