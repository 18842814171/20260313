#!/bin/bash

g++ -I./include ./tests/test_instmngr.cpp ./core/cpu.cpp ./memory/memory.cpp -o ./build/test_manager

./build/test_manager

