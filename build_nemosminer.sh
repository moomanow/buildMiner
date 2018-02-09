#!/bin/bash

# Simple script to create the Makefile and build

# export PATH="$PATH:/usr/local/cuda/bin/"
git submodule foreach git pull
cd nemosminer/ccminer/
sh build.sh
cd -
