#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"
sudo ln -s /usr/local/cuda-9.1/ /usr/local/cuda
sudo apt-get -y install libssl-dev
sudo apt-get -y install libcurl4-openssl-dev
sudo apt-get -y install libjansson-dev
sudo apt-get -y install automake
git submodule init
git submodule reset --hrad
git submodule update
git submodule foreach git pull

###########################################
cd tpruvot/ccminer/
sh build.sh
cp ccminer ..
cd -
cd ccminer-phi-anxmod/ccminer/
chmod +x ./autogen.sh
sh build.sh
cp ccminer ..
cd -
cd ccminer-xevan/ccminer/
#ccminer.cpp:45:26: fatal error: cuda_runtime.h: No such file or directory
sh build.sh
cp ccminer ..
cd -
cd klaust/ccminer/
sh build.sh
cp ccminer ..
cd -
cd nanashi/ccminer/
sh build.sh
cp ccminer ..
cd -
cd nemosminer/ccminer/
sh build.sh
cp ccminer ..
cd -
cd sp-hash/ccminer/
#remove compute_20 MakeFile.am
sed -i 's/-gencode=arch=compute_20,code=\\"sm_21,compute_20\\"//g' Makefile.am
sh build.sh
cp ccminer ..
cd -

