#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"
sudo ln -s /usr/local/cuda-9.1 /usr/local/cuda
sudo ln -s /usr/local/cuda-9.1 /usr/local/cuda-7.5
sudo apt-get -y install libssl-dev
sudo apt-get -y install bc
sudo apt-get -y install libcurl4-openssl-dev
sudo apt-get -y install libjansson-dev
sudo apt-get -y install automake
git submodule init
git submodule foreach git reset --hard
git submodule update
git submodule foreach git pull

###########################################
bash man-build.sh 216k155
bash man-build.sh ccminer-xevan
bash man-build.sh krnlx
bash man-build.sh nanashi
bash man-build.sh tpruvot
bash man-build.sh alexis78
bash man-build.sh ccminer-phi-anxmod
bash man-build.sh klaust
bash man-build.sh MSFTserver
bash man-build.sh nemosminer
bash man-build.sh sp-hash

