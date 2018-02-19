#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"
git submodule init
git submodule update
git submodule foreach git pull
cd tpruvot/ccminer/
sh build.sh
cd -
cd ccminer-phi-anxmod/ccminer/
sh build.sh
cd -
cd ccminer-xevan/ccminer/
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
sh build.sh
cd -

