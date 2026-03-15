#!/bin/bash

g++ -I./include ./memory/memory.cpp ./tests/test_membasic.cpp  -o ./build/test_membasic

./build/test_membasic

