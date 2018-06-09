#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"

if [ $? -ne 0 ]; then
  exit 1
fi
cd ${1}/ccminer 

#make -j$(nproc)
./build.sh
cp ccminer ../ccminer-run
mkdir -p ~/miner/${1}
cp ccminer ~/miner/${1}/ccminer-run
mkdir -p ~/minerAutoSwitch/bin/${1}
cp ccminer ~/minerAutoSwitch/bin/${1}/ccminer-run
cd -
