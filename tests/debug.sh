#!/bin/bash
# debug_test1.sh - Debug the exact command you want


gdb -q ./simulator \
    -ex "break main" \
    -ex "run /home/linda/3.8/my_sim/output/simple32" \
   