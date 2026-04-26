#ifndef MAPLOADER_HPP
#define MAPLOADER_HPP

#include "utils/color_schema.hpp"
#include <cstdint>
#include <string>
#include <vector>

struct MapImage {
    uint32_t width = 0;
    uint32_t height = 0;
    ColorFormat format = ColorFormat::RGB332;
    std::vector<uint8_t> pixels;
};

// Supported JSON schemas:
// 1) Direct pixels:
// {
//   "width": 4, "height": 2, "format": "rgb332",
//   "pixels": [[255,0,0], [0,255,0], ... width*height entries ...]
// }
//
// 2) Tile map:
// {
//   "tileWidth": 8, "tileHeight": 8,
//   "mapWidth": 64, "mapHeight": 48,
//   "format": "rgb332",
//   "palette": { "0": [0,0,0], "1": [255,255,255] },
//   "tiles": [[0,1,...], ... mapHeight rows ...]
// }
MapImage load_map_from_json_text(const std::string& json_text);
MapImage load_map_from_json_file(const std::string& file_path);

#endif
