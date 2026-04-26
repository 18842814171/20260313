#include "maploader.hpp"

#include <cctype>
#include <cmath>
#include <fstream>
#include <limits>
#include <algorithm>
#include <sstream>
#include <stdexcept>
#include <string>
#include <memory>
#include <unordered_map>
#include <utility>
#include <vector>

namespace {

struct JsonValue {
    enum class Type {
        Null,
        Bool,
        Number,
        String,
        Array,
        Object
    };

    Type type = Type::Null;
    bool bool_value = false;
    double number_value = 0.0;
    std::string string_value;
    std::vector<std::unique_ptr<JsonValue>> array_value;
    std::vector<std::pair<std::string, std::unique_ptr<JsonValue>>> object_value;
};

class JsonParser {
public:
    explicit JsonParser(const std::string& text) : text_(text) {}

    JsonValue parse() {
        skip_ws();
        JsonValue value = parse_value();
        skip_ws();
        if (!eof()) {
            throw std::runtime_error("Invalid JSON: trailing content");
        }
        return value;
    }

private:
    const std::string& text_;
    size_t pos_ = 0;

    bool eof() const { return pos_ >= text_.size(); }

    char peek() const {
        if (eof()) {
            return '\0';
        }
        return text_[pos_];
    }

    char get() {
        if (eof()) {
            throw std::runtime_error("Invalid JSON: unexpected EOF");
        }
        return text_[pos_++];
    }

    void skip_ws() {
        while (!eof() && std::isspace(static_cast<unsigned char>(text_[pos_])) != 0) {
            ++pos_;
        }
    }

    void expect(char c) {
        skip_ws();
        const char got = get();
        if (got != c) {
            throw std::runtime_error(std::string("Invalid JSON: expected '") + c + "'");
        }
    }

    bool consume_if(char c) {
        skip_ws();
        if (!eof() && text_[pos_] == c) {
            ++pos_;
            return true;
        }
        return false;
    }

    JsonValue parse_value() {
        skip_ws();
        const char c = peek();
        if (c == '{') return parse_object();
        if (c == '[') return parse_array();
        if (c == '"') return parse_string();
        if (c == 't' || c == 'f') return parse_bool();
        if (c == 'n') return parse_null();
        if (c == '-' || std::isdigit(static_cast<unsigned char>(c)) != 0) return parse_number();
        throw std::runtime_error("Invalid JSON: unknown token");
    }

    JsonValue parse_object() {
        JsonValue out;
        out.type = JsonValue::Type::Object;
        expect('{');
        skip_ws();
        if (consume_if('}')) {
            return out;
        }
        while (true) {
            JsonValue key = parse_string();
            expect(':');
            JsonValue value = parse_value();
            out.object_value.push_back(std::make_pair(key.string_value, std::make_unique<JsonValue>(std::move(value))));
            skip_ws();
            if (consume_if('}')) {
                break;
            }
            expect(',');
        }
        return out;
    }

    JsonValue parse_array() {
        JsonValue out;
        out.type = JsonValue::Type::Array;
        expect('[');
        skip_ws();
        if (consume_if(']')) {
            return out;
        }
        while (true) {
            JsonValue value = parse_value();
            out.array_value.push_back(std::make_unique<JsonValue>(std::move(value)));
            skip_ws();
            if (consume_if(']')) {
                break;
            }
            expect(',');
        }
        return out;
    }

    JsonValue parse_string() {
        JsonValue out;
        out.type = JsonValue::Type::String;
        expect('"');
        std::string s;
        while (true) {
            const char c = get();
            if (c == '"') {
                break;
            }
            if (c == '\\') {
                const char esc = get();
                switch (esc) {
                    case '"': s.push_back('"'); break;
                    case '\\': s.push_back('\\'); break;
                    case '/': s.push_back('/'); break;
                    case 'b': s.push_back('\b'); break;
                    case 'f': s.push_back('\f'); break;
                    case 'n': s.push_back('\n'); break;
                    case 'r': s.push_back('\r'); break;
                    case 't': s.push_back('\t'); break;
                    default:
                        throw std::runtime_error("Invalid JSON: unsupported escape");
                }
                continue;
            }
            s.push_back(c);
        }
        out.string_value = s;
        return out;
    }

    JsonValue parse_bool() {
        JsonValue out;
        out.type = JsonValue::Type::Bool;
        if (text_.compare(pos_, 4, "true") == 0) {
            out.bool_value = true;
            pos_ += 4;
            return out;
        }
        if (text_.compare(pos_, 5, "false") == 0) {
            out.bool_value = false;
            pos_ += 5;
            return out;
        }
        throw std::runtime_error("Invalid JSON: bad bool");
    }

    JsonValue parse_null() {
        if (text_.compare(pos_, 4, "null") != 0) {
            throw std::runtime_error("Invalid JSON: bad null");
        }
        pos_ += 4;
        JsonValue out;
        out.type = JsonValue::Type::Null;
        return out;
    }

    JsonValue parse_number() {
        skip_ws();
        const size_t begin = pos_;
        if (peek() == '-') {
            ++pos_;
        }
        if (eof() || std::isdigit(static_cast<unsigned char>(peek())) == 0) {
            throw std::runtime_error("Invalid JSON: bad number");
        }
        while (!eof() && std::isdigit(static_cast<unsigned char>(peek())) != 0) {
            ++pos_;
        }
        if (!eof() && peek() == '.') {
            ++pos_;
            if (eof() || std::isdigit(static_cast<unsigned char>(peek())) == 0) {
                throw std::runtime_error("Invalid JSON: bad fractional number");
            }
            while (!eof() && std::isdigit(static_cast<unsigned char>(peek())) != 0) {
                ++pos_;
            }
        }
        if (!eof() && (peek() == 'e' || peek() == 'E')) {
            ++pos_;
            if (!eof() && (peek() == '+' || peek() == '-')) {
                ++pos_;
            }
            if (eof() || std::isdigit(static_cast<unsigned char>(peek())) == 0) {
                throw std::runtime_error("Invalid JSON: bad exponent");
            }
            while (!eof() && std::isdigit(static_cast<unsigned char>(peek())) != 0) {
                ++pos_;
            }
        }
        const std::string token = text_.substr(begin, pos_ - begin);
        JsonValue out;
        out.type = JsonValue::Type::Number;
        out.number_value = std::stod(token);
        return out;
    }
};

const JsonValue& get_required_field(const JsonValue& object, const std::string& key) {
    for (const auto& kv : object.object_value) {
        if (kv.first == key) {
            return *kv.second;
        }
    }
    throw std::runtime_error("JSON field missing: " + key);
}

const JsonValue* get_optional_field(const JsonValue& object, const std::string& key) {
    for (const auto& kv : object.object_value) {
        if (kv.first == key) {
            return kv.second.get();
        }
    }
    return nullptr;
}

uint32_t to_u32(const JsonValue& value, const std::string& field_name) {
    if (value.type != JsonValue::Type::Number) {
        throw std::runtime_error("Field must be non-negative integer: " + field_name);
    }
    const double v = value.number_value;
    if (!std::isfinite(v) || v < 0.0) {
        throw std::runtime_error("Field must be non-negative integer: " + field_name);
    }
    const double rounded = std::round(v);
    if (std::fabs(v - rounded) > 1e-9) {
        throw std::runtime_error("Field must be integer-valued number: " + field_name);
    }
    if (rounded > static_cast<double>(std::numeric_limits<uint32_t>::max())) {
        throw std::runtime_error("Field out of uint32 range: " + field_name);
    }
    return static_cast<uint32_t>(rounded);
}

ColorRGB parse_color(const JsonValue& value, const std::string& field_name) {
    if (value.type != JsonValue::Type::Array || value.array_value.size() != 3) {
        throw std::runtime_error("Field must be [r,g,b] array: " + field_name);
    }
    ColorRGB out;
    out.r = static_cast<uint8_t>(to_u32(*value.array_value[0], field_name + "[0]") & 0xFFu);
    out.g = static_cast<uint8_t>(to_u32(*value.array_value[1], field_name + "[1]") & 0xFFu);
    out.b = static_cast<uint8_t>(to_u32(*value.array_value[2], field_name + "[2]") & 0xFFu);
    return out;
}

ColorFormat parse_format(const JsonValue& root) {
    const JsonValue* fmt = get_optional_field(root, "format");
    if (fmt == nullptr) {
        return ColorFormat::RGB332;
    }
    if (fmt->type != JsonValue::Type::String) {
        throw std::runtime_error("Field format must be a string");
    }
    if (fmt->string_value == "rgb332") {
        return ColorFormat::RGB332;
    }
    if (fmt->string_value == "gray8") {
        return ColorFormat::GRAY8;
    }
    throw std::runtime_error("Unsupported format: " + fmt->string_value);
}

uint8_t encode_color(ColorFormat format, const ColorRGB& c) {
    return (format == ColorFormat::RGB332) ? encode_rgb332(c) : encode_gray8(c);
}

double to_double(const JsonValue& value, const std::string& field_name) {
    if (value.type != JsonValue::Type::Number || !std::isfinite(value.number_value)) {
        throw std::runtime_error("Field must be finite number: " + field_name);
    }
    return value.number_value;
}

struct PointD {
    double x = 0.0;
    double y = 0.0;
};

struct SegmentD {
    PointD a;
    PointD b;
    uint8_t color = 0;
};

ColorRGB pick_layer_rgb(const std::string& layer) {
    static const std::unordered_map<std::string, ColorRGB> kLayerPalette = {
        {"巷道", {255, 255, 255}},     // white
        {"进尺", {255, 140, 0}},       // orange
        {"通风设施", {0, 255, 255}},   // cyan
        {"电缆", {255, 255, 0}},       // yellow
        {"积水线探水线", {0, 255, 0}}, // green
    };
    const auto it = kLayerPalette.find(layer);
    if (it != kLayerPalette.end()) {
        return it->second;
    }
    return ColorRGB{210, 210, 210}; // default light gray
}

const JsonValue* get_object_field(const JsonValue& obj, const std::string& key) {
    if (obj.type != JsonValue::Type::Object) {
        return nullptr;
    }
    return get_optional_field(obj, key);
}

PointD parse_point2d(const JsonValue& value, const std::string& field_name) {
    if (value.type != JsonValue::Type::Array || value.array_value.size() < 2) {
        throw std::runtime_error("Point must contain at least [x,y]: " + field_name);
    }
    PointD p;
    p.x = to_double(*value.array_value[0], field_name + "[0]");
    p.y = to_double(*value.array_value[1], field_name + "[1]");
    return p;
}

void draw_line(std::vector<uint8_t>& pixels, uint32_t width, uint32_t height,
               int x0, int y0, int x1, int y1, uint8_t color) {
    int dx = std::abs(x1 - x0);
    int sx = (x0 < x1) ? 1 : -1;
    int dy = -std::abs(y1 - y0);
    int sy = (y0 < y1) ? 1 : -1;
    int err = dx + dy;
    while (true) {
        if (x0 >= 0 && y0 >= 0 && x0 < static_cast<int>(width) && y0 < static_cast<int>(height)) {
            pixels[static_cast<size_t>(y0) * width + static_cast<size_t>(x0)] = color;
        }
        if (x0 == x1 && y0 == y1) {
            break;
        }
        int e2 = 2 * err;
        if (e2 >= dy) {
            err += dy;
            x0 += sx;
        }
        if (e2 <= dx) {
            err += dx;
            y0 += sy;
        }
    }
}

MapImage parse_cad_entity_array(const JsonValue& root) {
    // Keep output compact for device tests while preserving shape.
    constexpr uint32_t kOutputWidth = 512;
    constexpr uint32_t kOutputHeight = 512;
    const uint8_t bg = encode_rgb332(ColorRGB{0, 0, 0});

    std::vector<SegmentD> segments;
    segments.reserve(root.array_value.size());

    double min_x = std::numeric_limits<double>::infinity();
    double min_y = std::numeric_limits<double>::infinity();
    double max_x = -std::numeric_limits<double>::infinity();
    double max_y = -std::numeric_limits<double>::infinity();

    auto include_point = [&](const PointD& p) {
        min_x = std::min(min_x, p.x);
        min_y = std::min(min_y, p.y);
        max_x = std::max(max_x, p.x);
        max_y = std::max(max_y, p.y);
    };

    for (size_t i = 0; i < root.array_value.size(); ++i) {
        const JsonValue& entity = *root.array_value[i];
        const JsonValue* type_v = get_object_field(entity, "type");
        const JsonValue* attrs = get_object_field(entity, "attributes");
        if (type_v == nullptr || attrs == nullptr || type_v->type != JsonValue::Type::String) {
            continue;
        }
        const JsonValue* layer_v = get_object_field(entity, "layer");
        const std::string layer_name =
            (layer_v != nullptr && layer_v->type == JsonValue::Type::String) ? layer_v->string_value : "DEFAULT";
        const uint8_t layer_color = encode_rgb332(pick_layer_rgb(layer_name));

        if (type_v->string_value == "LWPOLYLINE") {
            const JsonValue* points_v = get_object_field(*attrs, "points");
            if (points_v == nullptr || points_v->type != JsonValue::Type::Array || points_v->array_value.size() < 2) {
                continue;
            }
            std::vector<PointD> pts;
            pts.reserve(points_v->array_value.size());
            for (size_t k = 0; k < points_v->array_value.size(); ++k) {
                PointD p = parse_point2d(*points_v->array_value[k], "attributes.points[]");
                pts.push_back(p);
                include_point(p);
            }
            for (size_t k = 1; k < pts.size(); ++k) {
                segments.push_back(SegmentD{pts[k - 1], pts[k], layer_color});
            }
            const JsonValue* closed = get_object_field(*attrs, "closed");
            const bool is_closed = (closed != nullptr && closed->type == JsonValue::Type::Bool && closed->bool_value);
            if (is_closed && pts.size() > 2) {
                segments.push_back(SegmentD{pts.back(), pts.front(), layer_color});
            }
            continue;
        }

        if (type_v->string_value == "LINE") {
            const JsonValue* start_v = get_object_field(*attrs, "start");
            const JsonValue* end_v = get_object_field(*attrs, "end");
            if (start_v == nullptr || end_v == nullptr) {
                continue;
            }
            PointD a = parse_point2d(*start_v, "attributes.start");
            PointD b = parse_point2d(*end_v, "attributes.end");
            include_point(a);
            include_point(b);
            segments.push_back(SegmentD{a, b, layer_color});
            continue;
        }
    }

    if (segments.empty() || !std::isfinite(min_x) || !std::isfinite(max_x) ||
        !std::isfinite(min_y) || !std::isfinite(max_y)) {
        throw std::runtime_error("CAD map contains no drawable entities");
    }

    const double span_x = std::max(1e-9, max_x - min_x);
    const double span_y = std::max(1e-9, max_y - min_y);
    const double scale_x = static_cast<double>(kOutputWidth - 1) / span_x;
    const double scale_y = static_cast<double>(kOutputHeight - 1) / span_y;
    const double scale = std::min(scale_x, scale_y);
    const double used_w = span_x * scale;
    const double used_h = span_y * scale;
    const double off_x = (static_cast<double>(kOutputWidth - 1) - used_w) * 0.5;
    const double off_y = (static_cast<double>(kOutputHeight - 1) - used_h) * 0.5;

    auto project_x = [&](double x) -> int {
        return static_cast<int>(std::lround((x - min_x) * scale + off_x));
    };
    auto project_y = [&](double y) -> int {
        // image-space Y grows downward
        return static_cast<int>(std::lround((max_y - y) * scale + off_y));
    };

    MapImage out;
    out.width = kOutputWidth;
    out.height = kOutputHeight;
    out.format = ColorFormat::RGB332;
    out.pixels.assign(static_cast<size_t>(out.width) * static_cast<size_t>(out.height), bg);

    for (const auto& s : segments) {
        draw_line(out.pixels, out.width, out.height,
                  project_x(s.a.x), project_y(s.a.y),
                  project_x(s.b.x), project_y(s.b.y),
                  s.color);
    }
    return out;
}

MapImage parse_direct_pixels(const JsonValue& root) {
    MapImage out;
    out.width = to_u32(get_required_field(root, "width"), "width");
    out.height = to_u32(get_required_field(root, "height"), "height");
    out.format = parse_format(root);

    const JsonValue& pixels = get_required_field(root, "pixels");
    if (pixels.type != JsonValue::Type::Array) {
        throw std::runtime_error("Field pixels must be an array");
    }

    const uint64_t expected = static_cast<uint64_t>(out.width) * static_cast<uint64_t>(out.height);
    if (pixels.array_value.size() != expected) {
        throw std::runtime_error("pixels size does not match width*height");
    }

    out.pixels.reserve(static_cast<size_t>(expected));
    for (size_t i = 0; i < pixels.array_value.size(); ++i) {
        const ColorRGB c = parse_color(*pixels.array_value[i], "pixels[" + std::to_string(i) + "]");
        out.pixels.push_back(encode_color(out.format, c));
    }
    return out;
}

MapImage parse_tile_map(const JsonValue& root) {
    MapImage out;
    const uint32_t tile_w = to_u32(get_required_field(root, "tileWidth"), "tileWidth");
    const uint32_t tile_h = to_u32(get_required_field(root, "tileHeight"), "tileHeight");
    const uint32_t map_w = to_u32(get_required_field(root, "mapWidth"), "mapWidth");
    const uint32_t map_h = to_u32(get_required_field(root, "mapHeight"), "mapHeight");
    out.format = parse_format(root);

    if (tile_w == 0 || tile_h == 0 || map_w == 0 || map_h == 0) {
        throw std::runtime_error("tile/map dimensions must be positive");
    }

    out.width = tile_w * map_w;
    out.height = tile_h * map_h;
    out.pixels.assign(static_cast<size_t>(out.width) * static_cast<size_t>(out.height), 0);

    const JsonValue& palette = get_required_field(root, "palette");
    if (palette.type != JsonValue::Type::Object) {
        throw std::runtime_error("Field palette must be an object");
    }
    std::unordered_map<int64_t, uint8_t> encoded_palette;
    for (const auto& entry : palette.object_value) {
        const int64_t key = std::stoll(entry.first);
        const ColorRGB c = parse_color(*entry.second, "palette." + entry.first);
        encoded_palette[key] = encode_color(out.format, c);
    }

    const JsonValue& tiles = get_required_field(root, "tiles");
    if (tiles.type != JsonValue::Type::Array || tiles.array_value.size() != map_h) {
        throw std::runtime_error("Field tiles must have mapHeight rows");
    }

    for (uint32_t ty = 0; ty < map_h; ++ty) {
        const JsonValue& row = *tiles.array_value[ty];
        if (row.type != JsonValue::Type::Array || row.array_value.size() != map_w) {
            throw std::runtime_error("Each tiles row must have mapWidth entries");
        }
        for (uint32_t tx = 0; tx < map_w; ++tx) {
            const int64_t tile_id = static_cast<int64_t>(to_u32(*row.array_value[tx], "tiles[][]"));
            const auto pit = encoded_palette.find(tile_id);
            if (pit == encoded_palette.end()) {
                throw std::runtime_error("Tile id missing in palette: " + std::to_string(tile_id));
            }
            const uint8_t pixel = pit->second;
            const uint32_t px0 = tx * tile_w;
            const uint32_t py0 = ty * tile_h;
            for (uint32_t py = 0; py < tile_h; ++py) {
                const uint32_t y = py0 + py;
                const uint32_t row_base = y * out.width;
                for (uint32_t px = 0; px < tile_w; ++px) {
                    out.pixels[row_base + (px0 + px)] = pixel;
                }
            }
        }
    }
    return out;
}

} // namespace

MapImage load_map_from_json_text(const std::string& json_text) {
    JsonParser parser(json_text);
    const JsonValue root = parser.parse();
    if (root.type == JsonValue::Type::Array) {
        return parse_cad_entity_array(root);
    }
    if (root.type != JsonValue::Type::Object) {
        throw std::runtime_error("Root JSON value must be object (tile/pixel map) or array (CAD entities)");
    }

    const bool has_direct_pixels = get_optional_field(root, "pixels") != nullptr;
    const bool has_tile_map = get_optional_field(root, "tiles") != nullptr;

    if (has_direct_pixels) {
        return parse_direct_pixels(root);
    }
    if (has_tile_map) {
        return parse_tile_map(root);
    }
    throw std::runtime_error("Unknown map schema: expected pixels or tiles");
}

MapImage load_map_from_json_file(const std::string& file_path) {
    std::ifstream in(file_path);
    if (!in.is_open()) {
        throw std::runtime_error("Failed to open map JSON file: " + file_path);
    }
    std::stringstream buffer;
    buffer << in.rdbuf();
    return load_map_from_json_text(buffer.str());
}
