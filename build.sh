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
cd alexis78/ccminer/
#ccminer.cpp:45:26: fatal error: cuda_runtime.h: No such file or directory
make distclean || echo clean

rm -f Makefile.in
rm -f config.status
./autogen.sh || echo done

extracflags="-march=native -D_REENTRANT -falign-functions=16 -falign-jumps=16 -falign-labels=16"
CUDA_CFLAGS="-O3 -lineno -Xcompiler -Wall -D_FORCE_INLINES" ./configure CXXFLAGS="-O3 $extracflags" --with-cuda=/usr/local/cuda --with-nvml=libnvidia-ml.so
#sh build.sh

make -j 6

cp ccminer ../ccminer-run
cd -

cd tpruvot/ccminer/
sh build.sh
cp ccminer ../ccminer-run
cd -
cd ccminer-phi-anxmod/ccminer/
chmod +x *.sh
sh build.sh
cp ccminer ../ccminer-run
cd -
cd ccminer-xevan/ccminer/
#ccminer.cpp:45:26: fatal error: cuda_runtime.h: No such file or directory
make distclean || echo clean

rm -f Makefile.in
rm -f config.status
./autogen.sh || echo done

extracflags="-march=native -D_REENTRANT -falign-functions=16 -falign-jumps=16 -falign-labels=16"
CUDA_CFLAGS="-O3 -lineno -Xcompiler -Wall -D_FORCE_INLINES" ./configure CXXFLAGS="-O3 $extracflags" --with-cuda=/usr/local/cuda --with-nvml=libnvidia-ml.so
#sh build.sh

make -j 6
cp ccminer ../ccminer-run
cd -
cd klaust/ccminer/
sh build.sh
cp ccminer ../ccminer-run
cd -
cd nanashi/ccminer/
sed -i 's/device_functions_decls.h/device_functions.h/g' equi/eqcuda.hpp
sh build.sh
cp ccminer ../ccminer-run
cd -
cd nemosminer/ccminer/
#sh build.sh
make distclean || echo clean

rm -f Makefile.in
rm -f config.status
./autogen.sh || echo done

extracflags="-march=native -D_REENTRANT -falign-functions=16 -falign-jumps=16 -falign-labels=16"
CUDA_CFLAGS="-O3 -lineno -Xcompiler -Wall -D_FORCE_INLINES" ./configure CXXFLAGS="-O3 $extracflags" --with-cuda=/usr/local/cuda --with-nvml=libnvidia-ml.so
#sh build.sh

make -j 6
cp ccminer ../ccminer-run
cd -
cd sp-hash/ccminer/
#remove compute_20 MakeFile.am
sed -i 's/-gencode=arch=compute_20,code=\\"sm_21,compute_20\\"//g' Makefile.am
sh build.sh
cp ccminer ../ccminer-run
cd -

