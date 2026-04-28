#include <algorithm>
#include <cctype>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <limits>
#include <regex>
#include <sstream>
#include <string>
#include <unordered_map>
#include <vector>

namespace {

struct RegWrite {
    int reg_index = -1;
    std::string value;
};

struct StepRecord {
    std::size_t step = 0;
    std::string inst;
    std::vector<RegWrite> reg_writes;
};

std::string resolve_log_input_path(const std::string& raw) {
    namespace fs = std::filesystem;
    if (raw.empty()) {
        return raw;
    }
    fs::path p(raw);
    if (p.is_absolute() || raw.find('/') != std::string::npos) {
        return raw;
    }
    const std::vector<std::string> candidates = {
        raw,
        "log/" + raw,
        "log/" + raw + ".txt",
        "log/-" + raw + ".txt"
    };
    for (const auto& c : candidates) {
        if (fs::exists(c)) {
            return c;
        }
    }
    return "log/" + raw;
}

std::string resolve_output_json_path(const std::string& raw) {
    if (raw.empty()) {
        return "plot/wave.json";
    }
    if (raw.find('/') != std::string::npos || std::filesystem::path(raw).is_absolute()) {
        return raw;
    }
    return "plot/" + raw;
}

std::string trim(const std::string& s) {
    std::size_t b = 0;
    while (b < s.size() && std::isspace(static_cast<unsigned char>(s[b])) != 0) {
        ++b;
    }
    std::size_t e = s.size();
    while (e > b && std::isspace(static_cast<unsigned char>(s[e - 1])) != 0) {
        --e;
    }
    return s.substr(b, e - b);
}

std::string json_escape(const std::string& s) {
    std::ostringstream out;
    for (const char c : s) {
        switch (c) {
            case '\\': out << "\\\\"; break;
            case '"': out << "\\\""; break;
            case '\n': out << "\\n"; break;
            case '\r': out << "\\r"; break;
            case '\t': out << "\\t"; break;
            default:
                out << c;
                break;
        }
    }
    return out.str();
}

std::vector<StepRecord> parse_log_steps(const std::string& log_path, std::size_t step_limit) {
    std::ifstream in(log_path);
    if (!in.is_open()) {
        throw std::runtime_error("无法打开日志文件: " + log_path);
    }

    std::regex step_re(R"(^\s*Step:\s*([0-9]+)\s*$)");
    std::regex inst_re(R"(^\s*\[INST\]\s*(.+)\s*$)");
    std::regex reg_re(R"(^\s*\[REG\]\s*x([0-9]+)\s*=\s*([^\s]+)\s*$)");
    std::smatch match;

    std::vector<StepRecord> steps;
    StepRecord current;
    bool have_current = false;

    std::string line;
    while (std::getline(in, line)) {
        if (std::regex_match(line, match, step_re)) {
            if (have_current) {
                steps.push_back(current);
            }
            current = StepRecord{};
            current.step = static_cast<std::size_t>(std::stoull(match[1].str()));
            have_current = true;
            if (steps.size() >= step_limit) {
                break;
            }
            continue;
        }
        if (!have_current) {
            continue;
        }
        if (std::regex_match(line, match, inst_re)) {
            current.inst = trim(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, reg_re)) {
            RegWrite w;
            w.reg_index = std::stoi(match[1].str());
            w.value = trim(match[2].str());
            current.reg_writes.push_back(w);
            continue;
        }
    }
    if (have_current && steps.size() < step_limit) {
        steps.push_back(current);
    }

    if (steps.size() > step_limit) {
        steps.resize(step_limit);
    }
    return steps;
}

void write_wave_json(const std::string& output_path, const std::string& source_log,
                     const std::vector<StepRecord>& steps) {
    std::ofstream out(output_path, std::ios::out | std::ios::trunc);
    if (!out.is_open()) {
        throw std::runtime_error("无法写出 JSON 文件: " + output_path);
    }

    std::unordered_map<int, std::vector<std::pair<std::size_t, std::string>>> reg_tracks;
    for (const auto& s : steps) {
        for (const auto& w : s.reg_writes) {
            reg_tracks[w.reg_index].push_back({s.step, w.value});
        }
    }

    std::vector<int> reg_ids;
    reg_ids.reserve(reg_tracks.size());
    for (const auto& kv : reg_tracks) {
        reg_ids.push_back(kv.first);
    }
    std::sort(reg_ids.begin(), reg_ids.end());

    out << "{\n";
    out << "  \"meta\": {\n";
    out << "    \"source_log\": \"" << json_escape(source_log) << "\",\n";
    out << "    \"step_count\": " << steps.size() << ",\n";
    out << "    \"timescale\": \"1step\"\n";
    out << "  },\n";

    out << "  \"steps\": [\n";
    for (std::size_t i = 0; i < steps.size(); ++i) {
        const auto& s = steps[i];
        out << "    {\n";
        out << "      \"step\": " << s.step << ",\n";
        out << "      \"inst\": \"" << json_escape(s.inst) << "\",\n";
        out << "      \"reg_writes\": [";
        for (std::size_t j = 0; j < s.reg_writes.size(); ++j) {
            const auto& w = s.reg_writes[j];
            if (j != 0) {
                out << ", ";
            }
            out << "{\"reg\": " << w.reg_index
                << ", \"value\": \"" << json_escape(w.value) << "\"}";
        }
        out << "]\n";
        out << "    }";
        if (i + 1 != steps.size()) {
            out << ",";
        }
        out << "\n";
    }
    out << "  ],\n";

    out << "  \"tracks\": [\n";
    for (std::size_t i = 0; i < reg_ids.size(); ++i) {
        const int reg_id = reg_ids[i];
        out << "    {\n";
        out << "      \"name\": \"x" << reg_id << "\",\n";
        out << "      \"samples\": [";
        const auto& samples = reg_tracks[reg_id];
        for (std::size_t j = 0; j < samples.size(); ++j) {
            if (j != 0) {
                out << ", ";
            }
            out << "{\"step\": " << samples[j].first
                << ", \"value\": \"" << json_escape(samples[j].second) << "\"}";
        }
        out << "]\n";
        out << "    }";
        if (i + 1 != reg_ids.size()) {
            out << ",";
        }
        out << "\n";
    }
    out << "  ]\n";
    out << "}\n";
}

}  // namespace

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "用法: " << argv[0]
                  << " <log-file> [output-json] [--max-wave-steps=<n>]\n"
                  << "  <log-file> 仅填文件名时自动尝试 log/、log/<name>.txt、log/-<name>.txt\n"
                  << "  [output-json] 仅填文件名时默认写到 plot/\n";
        return 1;
    }

    std::string log_path = resolve_log_input_path(argv[1]);
    std::string output_path = "plot/wave.json";
    std::size_t max_wave_steps = std::numeric_limits<std::size_t>::max();

    for (int i = 2; i < argc; ++i) {
        std::string a(argv[i]);
        constexpr const char kMaxPrefix[] = "--max-wave-steps=";
        if (a.compare(0, sizeof(kMaxPrefix) - 1, kMaxPrefix) == 0) {
            const std::string value = a.substr(sizeof(kMaxPrefix) - 1);
            try {
                const unsigned long long n = std::stoull(value);
                if (n > 0) {
                    max_wave_steps = static_cast<std::size_t>(n);
                }
            } catch (...) {
                std::cerr << "警告: 非法 --max-wave-steps 参数，已忽略: " << value << "\n";
            }
            continue;
        }
        output_path = resolve_output_json_path(a);
    }

    try {
        std::filesystem::path outp(output_path);
        if (!outp.parent_path().empty()) {
            std::filesystem::create_directories(outp.parent_path());
        }
        const auto steps = parse_log_steps(log_path, max_wave_steps);
        write_wave_json(output_path, log_path, steps);
        std::cout << "OK: " << output_path << " (steps=" << steps.size() << ")\n";
        return 0;
    } catch (const std::exception& ex) {
        std::cerr << "error: " << ex.what() << "\n";
        return 2;
    }
}
