#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"
sudo ln -s /usr/local/cuda-9.1/ /usr/local/cuda
sudo apt-get -y install libssl-dev
sudo apt-get -y install libcurl4-openssl-dev
sudo apt-get -y install libjansson-dev
sudo apt-get -y install automake
git submodule init
git submodule update
git submodule foreach git pull
cd tpruvot/ccminer/
sh build.sh
cd -
cd ccminer-phi-anxmod/ccminer/
chmod +x ./autogen.sh
sh build.sh
cd -
cd ccminer-xevan/ccminer/
#ccminer.cpp:45:26: fatal error: cuda_runtime.h: No such file or directory
sh build.sh
cd -
cd klaust/ccminer/
sh build.sh
cd -
cd tpruvot/ccminer/
sh build.sh
cd -
cd nemosminer/ccminer/
sh build.sh
cd -
cd sp-hash/ccminer/
#remove compute_20 MakeFile.in
sh build.sh
cd -

