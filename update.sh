#!/bin/bash

git submodule foreach git pull origin HEAD
git submodule update

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
bash man-build.sh djm34
bash man-build.sh phasiclabs
bash man-build.sh todd1251
