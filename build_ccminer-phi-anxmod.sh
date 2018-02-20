#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"
#git submodule foreach git pull
cd ccminer-phi-anxmod/ccminer/
git pull
sh build.sh
cd -
