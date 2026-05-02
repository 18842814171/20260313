#include <algorithm>
#include <cctype>
#include <cstdint>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <limits>
#include <map>
#include <regex>
#include <set>
#include <sstream>
#include <string>
#include <vector>

namespace {

struct RegWrite {
    std::string reg;
    std::string value;
    std::string from;
};

struct MemEvent {
    std::string kind;
    std::string addr;
    std::string data;
    int width = 0;
};

struct IfStage {
    std::string pc;
    std::string raw_inst;
};

struct IdStage {
    std::string opcode;
    std::string pc;
    std::string rs1;
    std::string rs2;
    std::string rd;
    std::string imm;
    std::string rs1_val;
    std::string rs2_val;
};

struct StepRecord {
    std::size_t step = 0;
    IfStage if_stage;
    IdStage id_stage;
    std::map<std::string, std::string> pipe_if_id;
    std::map<std::string, std::string> pipe_id_ex;
    std::map<std::string, std::string> pipe_ex_mem;
    std::map<std::string, std::string> pipe_mem_wb;
    std::string exec_line;
    std::string ex_result;
    std::vector<RegWrite> reg_writes;
    std::vector<MemEvent> mem_events;
    std::vector<std::string> events;
    /** 本周期日志中出现乘法单元 scoreboard 阻塞（与 load-use 等 STALL 区分） */
    bool mul_scoreboard_stall = false;
    bool mul_issue_event = false;
    bool mul_complete_event = false;
    std::string mul_issue_kind;
};

struct ParseResult {
    std::vector<StepRecord> steps;
    bool halted = false;
    int exit_code = -1;
    std::size_t ran_steps = 0;
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

int infer_mem_width(const std::string& op) {
    if (op == "SB" || op == "LB" || op == "LBU") return 1;
    if (op == "SH" || op == "LH" || op == "LHU") return 2;
    if (op == "SW" || op == "LW") return 4;
    return 0;
}

std::map<std::string, std::string> parse_pipe_fields(const std::string& payload) {
    std::map<std::string, std::string> fields;
    std::istringstream iss(payload);
    std::string token;
    while (iss >> token) {
        const auto pos = token.find('=');
        if (pos == std::string::npos || pos == 0 || pos + 1 >= token.size()) {
            continue;
        }
        const std::string k = token.substr(0, pos);
        const std::string v = token.substr(pos + 1);
        fields[k] = v;
    }
    return fields;
}

ParseResult parse_log_steps(const std::string& log_path, std::size_t step_limit) {
    std::ifstream in(log_path);
    if (!in.is_open()) {
        throw std::runtime_error("无法打开日志文件: " + log_path);
    }

    std::regex step_re(R"(^\s*Step:\s*([0-9]+)\s*$)");
    std::regex if_pc_re(R"(^\s*IF pc:\s*([^\s]+)\s*$)");
    std::regex raw_inst_re(R"(^\s*raw_inst:\s*([^\s]+)\s*$)");
    std::regex decoded_inst_re(R"(^\s*Decoded Instruction:\s*([^\s]+)\s*$)");
    std::regex id_pc_re(R"(^\s*ID pc:\s*([^\s]+)\s*$)");
    std::regex regs_re(R"(^\s*rs1=([x0-9]+)\s+rs2=([x0-9]+)\s+rd=([x0-9]+)\s*$)");
    std::regex imm_re(R"(^\s*imm=([^\s]+)\s*$)");
    std::regex reg_vals_re(R"(^\s*rs1_val=([^\s]+)\s+rs2_val=([^\s]+)\s*$)");
    std::regex exec_re(R"(^\s*EXEC:\s*(.+)\s*$)");
    std::regex ex_result_re(R"(^\s*EX result:\s*([^\s]+)\s*$)");
    std::regex wb_re(R"(^\s*WB:\s*(r[0-9]+)\s*=\s*([^\s]+)\s+\(from\s+([^)]+)\)\s*$)");
    std::regex mem_addr_re(R"(^\s*(SB|SH|SW|LB|LBU|LH|LHU|LW)\s+addr:\s*([^\s]+)\s*$)");
    std::regex mem_sw_detail_re(R"(^\s*SW:\s*Address=([^,]+),\s*Data=([^\s]+)\s*$)");
    std::regex mem_lw_detail_re(R"(^\s*LW:\s*Address=([^\s]+)\s*$)");
    std::regex pipe_if_id_re(R"(^\s*\[PIPE_IF_ID\]\s*(.+)\s*$)");
    std::regex pipe_id_ex_re(R"(^\s*\[PIPE_ID_EX\]\s*(.+)\s*$)");
    std::regex pipe_ex_mem_re(R"(^\s*\[PIPE_EX_MEM\]\s*(.+)\s*$)");
    std::regex pipe_mem_wb_re(R"(^\s*\[PIPE_MEM_WB\]\s*(.+)\s*$)");
    std::regex halted_re(R"(^\s*Halted \(ECALL/EBREAK\)\.\s*$)");
    std::regex ran_steps_re(R"(^\s*Ran\s+([0-9]+)\s+step\(s\).*exit_code\s*=\s*([0-9-]+)\s*$)");
    std::regex exit_code_re(R"(^\s*Exit code:\s*([0-9-]+)\s*$)");
    std::smatch match;

    ParseResult result;
    StepRecord current;
    bool have_current = false;
    std::string pending_mem_op;
    std::string pending_mem_addr;

    std::string line;
    while (std::getline(in, line)) {
        const std::string t = trim(line);
        if (std::regex_match(line, match, halted_re)) {
            result.halted = true;
            continue;
        }
        if (std::regex_match(line, match, ran_steps_re)) {
            result.ran_steps = static_cast<std::size_t>(std::stoull(match[1].str()));
            result.exit_code = std::stoi(match[2].str());
            continue;
        }
        if (std::regex_match(line, match, exit_code_re)) {
            result.exit_code = std::stoi(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, step_re)) {
            if (have_current) {
                result.steps.push_back(current);
            }
            current = StepRecord{};
            current.step = static_cast<std::size_t>(std::stoull(match[1].str()));
            have_current = true;
            pending_mem_op.clear();
            pending_mem_addr.clear();
            if (result.steps.size() >= step_limit) {
                break;
            }
            continue;
        }
        if (!have_current) {
            continue;
        }
        if (std::regex_match(line, match, if_pc_re)) {
            current.if_stage.pc = trim(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, raw_inst_re)) {
            current.if_stage.raw_inst = trim(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, decoded_inst_re)) {
            current.id_stage.opcode = trim(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, id_pc_re)) {
            current.id_stage.pc = trim(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, regs_re)) {
            current.id_stage.rs1 = trim(match[1].str());
            current.id_stage.rs2 = trim(match[2].str());
            current.id_stage.rd = trim(match[3].str());
            continue;
        }
        if (std::regex_match(line, match, imm_re)) {
            current.id_stage.imm = trim(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, reg_vals_re)) {
            current.id_stage.rs1_val = trim(match[1].str());
            current.id_stage.rs2_val = trim(match[2].str());
            continue;
        }
        if (std::regex_match(line, match, exec_re)) {
            current.exec_line = trim(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, ex_result_re)) {
            current.ex_result = trim(match[1].str());
            continue;
        }
        if (std::regex_match(line, match, wb_re)) {
            RegWrite w;
            w.reg = trim(match[1].str());
            w.value = trim(match[2].str());
            w.from = trim(match[3].str());
            current.reg_writes.push_back(w);
            continue;
        }
        if (std::regex_match(line, match, mem_addr_re)) {
            pending_mem_op = trim(match[1].str());
            pending_mem_addr = trim(match[2].str());
            MemEvent e;
            e.kind = (pending_mem_op[0] == 'L') ? "load" : "store";
            e.addr = pending_mem_addr;
            e.width = infer_mem_width(pending_mem_op);
            current.mem_events.push_back(e);
            continue;
        }
        if (std::regex_match(line, match, mem_sw_detail_re)) {
            MemEvent e;
            e.kind = "store";
            e.addr = trim(match[1].str());
            e.data = trim(match[2].str());
            e.width = 4;
            current.mem_events.push_back(e);
            continue;
        }
        if (std::regex_match(line, match, mem_lw_detail_re)) {
            MemEvent e;
            e.kind = "load";
            e.addr = trim(match[1].str());
            e.width = 4;
            current.mem_events.push_back(e);
            continue;
        }
        if (std::regex_match(line, match, pipe_if_id_re)) {
            current.pipe_if_id = parse_pipe_fields(trim(match[1].str()));
            continue;
        }
        if (std::regex_match(line, match, pipe_id_ex_re)) {
            current.pipe_id_ex = parse_pipe_fields(trim(match[1].str()));
            continue;
        }
        if (std::regex_match(line, match, pipe_ex_mem_re)) {
            current.pipe_ex_mem = parse_pipe_fields(trim(match[1].str()));
            continue;
        }
        if (std::regex_match(line, match, pipe_mem_wb_re)) {
            current.pipe_mem_wb = parse_pipe_fields(trim(match[1].str()));
            continue;
        }
        if (t.find("MUL/mult (multiplier): issue") != std::string::npos) {
            current.mul_issue_event = true;
            current.mul_issue_kind =
                (t.find("issue MULH") != std::string::npos) ? "MULH" : "MUL";
            continue;
        }
        if (t.find("MUL/mult (multiplier): complete") != std::string::npos) {
            current.mul_complete_event = true;
            continue;
        }
        if (t.find("MUL scoreboard stall") != std::string::npos) {
            current.mul_scoreboard_stall = true;
            continue;
        }
        if (t.find("FLUSH:") != std::string::npos ||
            t.find("STALL") != std::string::npos ||
            t.find("hazard") != std::string::npos ||
            t.find("Fetch stalled") != std::string::npos ||
            t.find("FWD:") != std::string::npos) {
            current.events.push_back(t);
        }
    }
    if (have_current && result.steps.size() < step_limit) {
        result.steps.push_back(current);
    }

    if (result.steps.size() > step_limit) {
        result.steps.resize(step_limit);
    }
    return result;
}

/** 乘法未写回周期内若插入 scoreboard stall，波形上应用 MUL/MULH 拉平，避免误显示后续 ADDI 气泡。 */
static std::vector<std::string> effective_opcode_per_step(const std::vector<StepRecord>& steps) {
    std::vector<std::string> out;
    out.reserve(steps.size());
    bool mul_busy = false;
    std::string last_kind = "MUL";
    for (const auto& s : steps) {
        std::string op = s.id_stage.opcode;
        if (mul_busy && s.mul_scoreboard_stall) {
            op = last_kind.empty() ? "MUL" : last_kind;
        }
        out.push_back(op);
        if (s.mul_issue_event) {
            mul_busy = true;
            if (!s.mul_issue_kind.empty()) {
                last_kind = s.mul_issue_kind;
            }
        }
        if (s.mul_complete_event) {
            mul_busy = false;
        }
    }
    return out;
}

void write_wave_json(const std::string& output_path, const std::string& source_log,
                     const ParseResult& parsed) {
    std::ofstream out(output_path, std::ios::out | std::ios::trunc);
    if (!out.is_open()) {
        throw std::runtime_error("无法写出 JSON 文件: " + output_path);
    }

    const auto& steps = parsed.steps;
    const std::vector<std::string> opcode_eff = effective_opcode_per_step(steps);
    std::map<std::string, std::vector<std::pair<std::size_t, std::string>>> tracks;
    for (std::size_t si = 0; si < steps.size(); ++si) {
        const auto& s = steps[si];
        if (!s.if_stage.pc.empty()) tracks["pc_if"].push_back({s.step, s.if_stage.pc});
        if (!s.id_stage.pc.empty()) tracks["pc_id"].push_back({s.step, s.id_stage.pc});
        if (!opcode_eff[si].empty()) tracks["opcode"].push_back({s.step, opcode_eff[si]});
        if (!s.ex_result.empty()) tracks["ex_result"].push_back({s.step, s.ex_result});
        if (!s.events.empty()) tracks["control"].push_back({s.step, s.events.front()});
        if (!s.mem_events.empty()) {
            tracks["mem_addr"].push_back({s.step, s.mem_events.front().addr});
            tracks["mem_rw"].push_back({s.step, s.mem_events.front().kind});
        }
        for (const auto& w : s.reg_writes) {
            tracks["wb_reg"].push_back({s.step, w.reg});
            tracks["wb_val"].push_back({s.step, w.value});
        }
        for (const auto& kv : s.pipe_if_id) {
            tracks["pipe_if_id." + kv.first].push_back({s.step, kv.second});
        }
        for (const auto& kv : s.pipe_id_ex) {
            tracks["pipe_id_ex." + kv.first].push_back({s.step, kv.second});
        }
        for (const auto& kv : s.pipe_ex_mem) {
            tracks["pipe_ex_mem." + kv.first].push_back({s.step, kv.second});
        }
        for (const auto& kv : s.pipe_mem_wb) {
            tracks["pipe_mem_wb." + kv.first].push_back({s.step, kv.second});
        }
    }

    out << "{\n";
    out << "  \"meta\": {\n";
    out << "    \"source_log\": \"" << json_escape(source_log) << "\",\n";
    out << "    \"step_count\": " << steps.size() << ",\n";
    out << "    \"halted\": " << (parsed.halted ? "true" : "false") << ",\n";
    out << "    \"exit_code\": " << parsed.exit_code << ",\n";
    out << "    \"ran_steps\": " << parsed.ran_steps << ",\n";
    out << "    \"timescale\": \"1step\"\n";
    out << "  },\n";

    out << "  \"steps\": [\n";
    for (std::size_t i = 0; i < steps.size(); ++i) {
        const auto& s = steps[i];
        out << "    {\n";
        out << "      \"step\": " << s.step << ",\n";
        out << "      \"if\": {\"pc\": \"" << json_escape(s.if_stage.pc)
            << "\", \"raw_inst\": \"" << json_escape(s.if_stage.raw_inst) << "\"},\n";
        out << "      \"id\": {"
            << "\"opcode\": \"" << json_escape(opcode_eff[i]) << "\", "
            << "\"pc\": \"" << json_escape(s.id_stage.pc) << "\", "
            << "\"rs1\": \"" << json_escape(s.id_stage.rs1) << "\", "
            << "\"rs2\": \"" << json_escape(s.id_stage.rs2) << "\", "
            << "\"rd\": \"" << json_escape(s.id_stage.rd) << "\", "
            << "\"imm\": \"" << json_escape(s.id_stage.imm) << "\", "
            << "\"rs1_val\": \"" << json_escape(s.id_stage.rs1_val) << "\", "
            << "\"rs2_val\": \"" << json_escape(s.id_stage.rs2_val) << "\"},\n";
        out << "      \"pipe\": {\n";
        auto write_pipe_object = [&](const char* name, const std::map<std::string, std::string>& m, bool comma) {
            out << "        \"" << name << "\": {";
            std::size_t c = 0;
            for (const auto& kv : m) {
                if (c++ != 0) out << ", ";
                out << "\"" << json_escape(kv.first) << "\": \"" << json_escape(kv.second) << "\"";
            }
            out << "}";
            if (comma) out << ",";
            out << "\n";
        };
        write_pipe_object("if_id", s.pipe_if_id, true);
        write_pipe_object("id_ex", s.pipe_id_ex, true);
        write_pipe_object("ex_mem", s.pipe_ex_mem, true);
        write_pipe_object("mem_wb", s.pipe_mem_wb, false);
        out << "      },\n";
        out << "      \"ex\": {\"exec\": \"" << json_escape(s.exec_line)
            << "\", \"result\": \"" << json_escape(s.ex_result) << "\"},\n";
        out << "      \"wb\": [";
        for (std::size_t j = 0; j < s.reg_writes.size(); ++j) {
            const auto& w = s.reg_writes[j];
            if (j != 0) {
                out << ", ";
            }
            out << "{\"reg\": \"" << json_escape(w.reg)
                << "\", \"value\": \"" << json_escape(w.value)
                << "\", \"from\": \"" << json_escape(w.from) << "\"}";
        }
        out << "],\n";
        out << "      \"mem\": [";
        for (std::size_t j = 0; j < s.mem_events.size(); ++j) {
            const auto& e = s.mem_events[j];
            if (j != 0) {
                out << ", ";
            }
            out << "{\"kind\": \"" << json_escape(e.kind)
                << "\", \"addr\": \"" << json_escape(e.addr)
                << "\", \"data\": \"" << json_escape(e.data)
                << "\", \"width\": " << e.width << "}";
        }
        out << "],\n";
        out << "      \"events\": [";
        for (std::size_t j = 0; j < s.events.size(); ++j) {
            if (j != 0) {
                out << ", ";
            }
            out << "\"" << json_escape(s.events[j]) << "\"";
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
    std::size_t i = 0;
    for (const auto& kv : tracks) {
        out << "    {\n";
        out << "      \"name\": \"" << json_escape(kv.first) << "\",\n";
        out << "      \"samples\": [";
        const auto& samples = kv.second;
        for (std::size_t j = 0; j < samples.size(); ++j) {
            if (j != 0) {
                out << ", ";
            }
            out << "{\"step\": " << samples[j].first
                << ", \"value\": \"" << json_escape(samples[j].second) << "\"}";
        }
        out << "]\n";
        out << "    }";
        ++i;
        if (i != tracks.size()) {
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
        const auto parsed = parse_log_steps(log_path, max_wave_steps);
        write_wave_json(output_path, log_path, parsed);
        std::cout << "OK: " << output_path << " (steps=" << parsed.steps.size() << ")\n";
        return 0;
    } catch (const std::exception& ex) {
        std::cerr << "error: " << ex.what() << "\n";
        return 2;
    }
}
