#!/usr/bin/bash

CNT=10
OPTION="RUST_MODE=release OPT=-O3"
OUT=bench.log

echo START BENCHMARK $(date) >> $OUT

make clean
make kernel/kernel USERTEST=yes $OPTION
make fs.img USERTEST=yes $OPTION

for i in $(seq 1 $CNT); do
    { time make qemu USERTEST=yes $OPTION 2>/dev/null ; } 2>> $OUT
    rm fs.img
    make fs.img USERTEST=yes $OPTION
done
