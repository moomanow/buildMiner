#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"
git submodule foreach git pull
cd sp-hash/ccminer/
sh build.sh
cd -
