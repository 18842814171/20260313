// main.cpp - Main entry point for simulator
#include "simulator.hpp"
#include "Instmngr.hpp"
#include "CPU.hpp"
#include "Device.hpp"
#include "Decoder.hpp"
#include "Loader.hpp"
#include "Interrupt.hpp"
#include "utils/utils.hpp"
#include "inst/arithm.hpp"
#include "inst/load_store.hpp"
#include "inst/auipc.hpp"
#include "inst/beq.hpp"
#include "inst/jump.hpp"
#include "inst/system.hpp"
#include "inst/lui.hpp"
#include "inst/opcode.hpp"
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <string>
#include <tuple>

// Returns: infile, max_steps
static std::tuple<std::string, size_t> parseArgs(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0]
                  << " <infile> [max_steps]\n"
                  << "  max_steps: optional; default 0 (unlimited, until halt).\n";
        std::exit(1);
    }

    std::string input_filename = argv[1];
    size_t max_steps = 0;

    if (argc >= 3) {
        try {
            size_t pos = 0;
            unsigned long long v = std::stoull(argv[2], &pos, 10);
            if (pos == 0 || argv[2][pos] != '\0')
                throw std::invalid_argument("trailing junk");
            max_steps = static_cast<size_t>(v);
        } catch (const std::exception&) {
            std::cerr << "Invalid max_steps: \"" << argv[2] << "\" (need a non-negative integer)\n";
            std::exit(1);
        }
    }

    return std::make_tuple(input_filename, max_steps);
}

int main(int argc, char* argv[]) {
    std::string infile;
    size_t max_steps = 0;
    std::tie(infile, max_steps) = parseArgs(argc, argv);
    simulator(infile, max_steps);
    return 0;
}
