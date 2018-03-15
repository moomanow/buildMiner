#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"

if [ $? -ne 0 ]; then
  exit 1
fi
cd ${1}/ccminer 
aclocal && autoheader && automake --add-missing --gnu --copy && autoconf

extracflags="-march=native -D_REENTRANT -falign-functions=16 -falign-jumps=16 -falign-labels=16"

CUDA_CFLAGS="-O3 -lineno -Xcompiler -Wall -D_FORCE_INLINES" ./configure CXXFLAGS="-O3 $extracflags" --with-cuda=/usr/local/cuda --with-nvml=libnvidia-ml.so

make -j4
cp ccminer ../ccminer-run
cd -
