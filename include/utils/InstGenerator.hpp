/**
 * @file InstGenerator.hpp
 * @brief 指令生成器 - 交互式添加新指令的工具
 */
#ifndef INST_GENERATOR_HPP
#define INST_GENERATOR_HPP

#include <iostream>
#include <fstream>
#include <string>
#include <bitset>
#include <cctype>
#include <algorithm>

class InstGenerator {
public:
    struct InstParams {
        std::string name;
        std::string type;       // R, I, S, B, U, J, SYSTEM
        uint32_t opcode;
        uint32_t funct3;
        uint32_t funct7;
        std::string alu_op;     // ALU operation name
        bool use_imm;
        bool reg_write;
        bool mem_read;
        bool mem_write;
        std::string hpp_file;
    };

    void generate() {
        std::cout << "\n========== Add Instructions ==========\n";
        std::cout << "This wizard will help you add a new instruction.\n\n";

        list_existing_files();

        InstParams params = collect_params();

        write_instruction_file(params);
        print_encoding_definition(params);
        print_registration_code(params);
        print_decoder_code(params);

        std::cout << "Press Enter to continue...";
        std::cin.get();
    }

private:
    void list_existing_files() {
        std::cout << "Existing instruction files in include/inst/:\n";
        std::cout << "  arithm.hpp, load_store.hpp, auipc.hpp, beq.hpp,\n";
        std::cout << "  jump.hpp, system.hpp, lui.hpp, opcode.hpp, encoding.hpp\n\n";
    }

    InstParams collect_params() {
        InstParams params;

        // Instruction name
        std::cout << "Enter new instruction name (e.g., MUL, DIV, SLL): ";
        std::getline(std::cin, params.name);
        if (params.name.empty()) {
            std::cout << "Cancelled.\n";
            return params;
        }
        for (auto& c : params.name) c = std::toupper(c);

        // Instruction type
        params.type = select_type();

        // Encoding parameters
        params.opcode = input_opcode();
        params.funct3 = input_funct3(params.type);
        params.funct7 = input_funct7(params.type);

        std::cout << "\nEncoding summary:\n";
        std::cout << "  Instruction: " << params.name << "\n";
        std::cout << "  Type: " << params.type << "-type\n";
        std::cout << "  Opcode: 0x" << std::hex << params.opcode << std::dec << "\n";
        std::cout << "  Funct3: " << params.funct3 << " (0b" << std::bitset<3>(params.funct3) << ")\n";
        std::cout << "  Funct7: 0x" << std::hex << params.funct7 << std::dec << "\n";

        // ALU operation
        params.alu_op = select_alu_op();

        // Immediate usage
        params.use_imm = input_use_imm(params.type);

        // Control signals
        input_control_signals(params);

        // Target file
        params.hpp_file = input_target_file(params.name);

        return params;
    }

    std::string select_type() {
        std::cout << "\nInstruction type:\n";
        std::cout << "  1. R-type (reg-reg: ADD, SUB, MUL, ...)\n";
        std::cout << "  2. I-type (reg-imm: ADDI, LW, JALR, ...)\n";
        std::cout << "  3. S-type (store: SW, SH, SB, ...)\n";
        std::cout << "  4. B-type (branch: BEQ, BNE, ...)\n";
        std::cout << "  5. U-type (upper imm: LUI, AUIPC)\n";
        std::cout << "  6. J-type (jump: JAL)\n";
        std::cout << "  7. System (ECALL, EBREAK, CSR, ...)\n";
        std::cout << "Select type: ";
        std::string choice;
        std::getline(std::cin, choice);

        std::string type;
        if (choice == "1") type = "R";
        else if (choice == "2") type = "I";
        else if (choice == "3") type = "S";
        else if (choice == "4") type = "B";
        else if (choice == "5") type = "U";
        else if (choice == "6") type = "J";
        else if (choice == "7") type = "SYSTEM";
        else {
            std::cout << "Invalid type. Cancelled.\n";
            return "";
        }
        std::cout << "Selected type: " << type << "-type\n\n";
        return type;
    }

    uint32_t input_opcode() {
        std::cout << "Enter encoding parameters:\n";
        std::cout << "  Opcode (hex, e.g., 0x33 for R-type, 0x13 for I-type): ";
        std::string opcode_str;
        std::getline(std::cin, opcode_str);
        return std::stoi(opcode_str, nullptr, 16);
    }

    uint32_t input_funct3(const std::string& type) {
        if (type.empty()) return 0;
        std::cout << "  Funct3 (decimal 0-7 or hex with 0x): ";
        std::string f3_str;
        std::getline(std::cin, f3_str);
        if (f3_str.find("0x") != std::string::npos) {
            return std::stoi(f3_str, nullptr, 16);
        }
        return std::stoi(f3_str);
    }

    uint32_t input_funct7(const std::string& type) {
        if (type != "R" && type != "I" && type != "SYSTEM") return 0;
        std::cout << "  Funct7 (hex, e.g., 0x00 or 0x20): ";
        std::string f7_str;
        std::getline(std::cin, f7_str);
        return std::stoi(f7_str, nullptr, 16);
    }

    std::string select_alu_op() {
        std::cout << "\nALU operation:\n";
        std::cout << "  0. ADD (addition)      7. SRA (shift right arithmetic)\n";
        std::cout << "  1. SUB (subtraction)   8. SLT (set less than)\n";
        std::cout << "  2. AND                 9. SLTU (set less than unsigned)\n";
        std::cout << "  3. OR                 10. MUL\n";
        std::cout << "  4. XOR                11. DIV\n";
        std::cout << "  5. SLL (shift left)   12. REM\n";
        std::cout << "  6. SRL (shift right)\n";
        std::cout << "Select ALU op: ";
        std::string alu_str;
        std::getline(std::cin, alu_str);
        int alu_op = std::stoi(alu_str);

        std::string alu_ops[] = {"ADD", "SUB", "AND", "OR", "XOR", "SLL", "SRL", "SRA", "SLT", "SLTU", "MUL", "DIV", "REM"};
        return alu_ops[alu_op];
    }

    bool input_use_imm(const std::string& type) {
        if (type == "R") {
            std::cout << "\nDoes this instruction use immediate? (n/y): ";
            std::string use_imm_str;
            std::getline(std::cin, use_imm_str);
            return (use_imm_str == "y" || use_imm_str == "Y");
        }
        return (type == "I" || type == "S" || type == "B" || type == "J");
    }

    void input_control_signals(InstParams& params) {
        params.reg_write = true;
        params.mem_read = false;
        params.mem_write = false;

        if (params.type == "S" || params.type == "B") {
            params.reg_write = false;
        }
        if (params.type == "S" || params.type == "I") {
            std::cout << "\nDoes this instruction access memory?\n";
            std::cout << "  0. No memory access\n";
            std::cout << "  1. Memory read (like LW)\n";
            std::cout << "  2. Memory write (like SW)\n";
            std::cout << "Select: ";
            std::string mem_str;
            std::getline(std::cin, mem_str);
            if (mem_str == "1") params.mem_read = true;
            else if (mem_str == "2") params.mem_write = true;
        }
    }

    std::string input_target_file(const std::string& name) {
        std::cout << "\nEnter target hpp file name (e.g., custom_inst.hpp) [empty = auto]: ";
        std::string hpp_file;
        std::getline(std::cin, hpp_file);
        if (hpp_file.empty()) {
            hpp_file = "custom_" + name + ".hpp";
        }
        if (hpp_file.find(".hpp") == std::string::npos) {
            hpp_file += ".hpp";
        }
        return hpp_file;
    }

    void write_instruction_file(const InstParams& params) {
        std::string hpp_path = "include/inst/" + params.hpp_file;

        std::ifstream check(hpp_path);
        bool file_exists = check.good();
        check.close();

        if (file_exists) {
            std::cout << "\nWarning: " << hpp_path << " exists. Append? (y/n): ";
            std::string append_str;
            std::getline(std::cin, append_str);
            if (append_str != "y" && append_str != "Y") {
                std::cout << "Cancelled.\n";
                return;
            }
        }

        std::ofstream out(hpp_path, std::ios::app);
        if (!out.is_open()) {
            std::cerr << "Error: Cannot create " << hpp_path << "\n";
            return;
        }

        if (!file_exists) {
            out << "// " << hpp_path << "\n";
            out << "#ifndef INST_" << params.name << "_HPP\n";
            out << "#define INST_" << params.name << "_HPP\n";
            out << "#include \"utils/utils.hpp\"\n";
            out << "#include \"CPU.hpp\"\n";
            out << "#include \"ALU.hpp\"\n\n";
        }

        std::string func_name = "inst_" + params.name;
        std::transform(func_name.begin(), func_name.end(), func_name.begin(),
                       [](unsigned char c){ return std::tolower(c); });

        out << "inline void " << func_name << "(CPU& cpu, Pipe_ID_EX& in, Pipe_EX_MEM& out) {\n";
        out << "    out.valid = in.valid;\n";
        out << "    out.rd = in.rd;\n\n";
        out << "    uint32_t in1 = in.val_rs1;\n";

        if (params.use_imm) {
            out << "    uint32_t in2 = in.alu_src ? in.imm : in.val_rs2;\n\n";
        } else {
            out << "    uint32_t in2 = in.val_rs2;\n\n";
        }

        out << "    out.alu_result = alu_execute(ALU_" << params.alu_op << ", in1, in2);\n\n";

        if (params.mem_write) {
            out << "    out.val_rs2 = in.val_rs2;\n";
        }

        out << "    // Control signals\n";
        out << "    out.reg_write = " << (params.reg_write ? "true" : "false") << ";\n";
        out << "    out.mem_read = " << (params.mem_read ? "true" : "false") << ";\n";
        out << "    out.mem_write = " << (params.mem_write ? "true" : "false") << ";\n";
        out << "    LOG(\"" << params.name << ": in1=\" + std::to_string(in1) + \", in2=\" + std::to_string(in2)\n";
        out << "          + \", result=\" + std::to_string(out.alu_result));\n";
        out << "}\n\n";

        out.close();
        std::cout << "\nGenerated: " << hpp_path << "\n";
    }

    void print_encoding_definition(const InstParams& params) {
        std::cout << "\nTo add encoding, add this to include/inst/encoding.hpp:\n\n";
        std::cout << "constexpr uint32_t INST_" << params.name << " =\n";
        std::cout << "    make_inst_id(0x" << std::hex << params.opcode << ", " << std::dec << params.funct3;
        if (params.funct7 > 0 || params.type == "R") {
            std::cout << ", 0x" << std::hex << params.funct7;
        }
        std::cout << std::dec << ");\n\n";
    }

    void print_registration_code(const InstParams& params) {
        std::string func_name = "inst_" + params.name;
        std::transform(func_name.begin(), func_name.end(), func_name.begin(),
                       [](unsigned char c){ return std::tolower(c); });

        std::cout << "To register the instruction, add this to core/simulator_api.cpp:\n\n";
        std::cout << "1. Add include:\n";
        std::cout << "   #include \"inst/" << params.hpp_file << "\"\n\n";
        std::cout << "2. Add registration:\n";
        std::cout << "   im->register_inst(INST_" << params.name << ", \"" << params.name << "\", " << func_name << ");\n\n";
    }

    void print_decoder_code(const InstParams& params) {
        std::string op_type;
        if (params.type == "R") op_type = "OP_OP";
        else if (params.type == "I") op_type = "OP_IMM";
        else if (params.type == "S") op_type = "OP_STORE";
        else if (params.type == "B") op_type = "OP_BRANCH";
        else if (params.type == "U") op_type = "OP_LUI";
        else if (params.type == "J") op_type = "OP_JAL";
        else if (params.type == "SYSTEM") op_type = "OP_SYSTEM";

        std::cout << "3. To update Decoder.cpp, add a case in inst_id():\n\n";
        std::cout << "   case " << op_type << ":  // 0x" << std::hex << params.opcode << std::dec << "\n";
        std::cout << "       if (f3 == " << params.funct3 << ") return INST_" << params.name << ";\n";
        std::cout << "       break;\n\n";
    }
};

#endif // INST_GENERATOR_HPP
