#! /bin/sh
curl -o ~/.bash_aliases https://raw.githubusercontent.com/moomanow/buildMiner/master/.bash_aliases
curl -o ~/.screenrc https://raw.githubusercontent.com/moomanow/buildMiner/master/.screenrc
git clone https://github.com/moomanow/buildMiner.git ~/buildMiner
sudo apt-get -y install libssl-dev
sudo apt-get -y install bc
sudo apt-get -y install libcurl4-openssl-dev
sudo apt-get -y install libjansson-dev
sudo apt-get -y install automake
cd ~/buildMiner
git submodule init
git submodule foreach git reset --hard
git submodule update
git submodule foreach git pull

sudo ln -s /usr/local/cuda-9.1 /usr/local/cuda
sudo ln -s /usr/local/cuda-9.1 /usr/local/cuda-7.5
