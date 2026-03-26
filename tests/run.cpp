#include <iostream>
#include <string>
#include <vector>
//#include "include/Types.hpp"
// Forward declaration of the simulator function
//void simulator(std::string infile, std::string outfile);

int main() {
    
    // Define your test files here
    std::string test_input = "/home/linda/3.8/my_sim/output/simple32";
    std::string test_output = "out326.txt";

    try {
        // Direct call to the simulator
        simulator(test_input, test_output);
        std::cout << "Test completed successfully. Check " << test_output << " for results." << std::endl;
    } catch (const std::exception& e) {
        std::cerr << "Simulation failed with error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}