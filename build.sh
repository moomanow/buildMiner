#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"
cd tpruvot/ccminer/
make distclean || echo clean

rm -f Makefile.in
rm -f config.status
./autogen.sh || echo done

# CFLAGS="-O2" ./configure
#./configure.sh
extracflags="-march=native -D_REENTRANT -falign-functions=16 -falign-jumps=16 -falign-labels=16"

CUDA_CFLAGS="-O3 -lineno -Xcompiler -Wall  -D_FORCE_INLINES" \
        ./configure CXXFLAGS="-O3 $extracflags" --with-cuda=/usr/local/cuda-9.1 --with-nvml=libnvidia-ml.so

make -j 4

