#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"

if [ $? -ne 0 ]; then
  exit 1
fi
cd ${1}/ccminer 
if [ "$1" == nanashi ]; then
  sed -i 's/device_functions_decls.h/device_functions.h/g' equi/eqcuda.hpp
fi
if [ "$1" == sp-hash ]; then
  sed -i 's/-gencode=arch=compute_20,code=\\"sm_21,compute_20\\"//g' Makefile.am
fi
./build.sh
cp ccminer ../ccminer-run
mkdir -p ~/miner/${1}
cp ccminer ~/miner/${1}/ccminer-run
mkdir -p ~/minerAutoSwitch/bin/${1}
cp ccminer ~/minerAutoSwitch/bin/${1}/ccminer-run
cd -
