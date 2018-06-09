#!/usr/bin/env bash

#
# miner.sh
# Author: Nils Knieling - https://github.com/Cyclenerd/ethereum_nvidia_miner
#
# Start etherminer and set power limit
#

# Load global settings settings.conf
if ! source ~/settings.conf; then
        echo "FAILURE: Can not load global settings 'settings.conf'"
        exit 9
fi
curl -f "https://raw.githubusercontent.com/viatoro/setupaddress/master/address.sh" -o ~/address.sh
source ~/address.sh
# Set power limit
sudo nvidia-smi -pm ENABLED
#sudo nvidia-smi -pl "$MY_WATT"


for MY_DEVICE in {0..18}
do
        # Check if card exists
        if nvidia-smi -i $MY_DEVICE >> /dev/null 2>&1; then
                #nvidia-settings -a "[gpu:$MY_DEVICE]/GPUPowerMizerMode=1"
                # Fan speed
                #nvidia-settings -a "[gpu:$MY_DEVICE]/GPUFanControlState=1"
                #nvidia-settings -a "[fan:$MY_DEVICE]/GPUTargetFanSpeed=$MY_FAN"
                # Graphics clock
                #nvidia-settings -a "[gpu:$MY_DEVICE]/GPUGraphicsClockOffset[3]=$MY_CLOCK"
                # Memory clock
                #nvidia-settings -a "[gpu:$MY_DEVICE]/GPUMemoryTransferRateOffset[3]=$MY_MEM"
                # Set watt/powerlimit. This is also set in miner.sh at autostart.
                { IFS=', ' read PW_LIMIT ; } < <(nvidia-smi -i $MY_DEVICE --query-gpu=power.default_limit --format=csv,noheader,nounits)
                GPU_WAT=$( echo "scale=0;$PW_LIMIT*$MY_WATT_PERCENT"|bc)
                sudo nvidia-smi -i "$MY_DEVICE" -pl "$GPU_WAT"
        fi
done

echo

export GPU_FORCE_64BIT_PTR=0
export GPU_MAX_HEAP_SIZE=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100


#
# Ethereum Mining
#

# ethminer
# https://github.com/ethereum-mining/ethminer
# Use -G (opencl) or -U (cuda) flag to select GPU platform.
#~/ethereum-mining/ethminer/build/ethminer/ethminer --farm-recheck 200 -U -S "eu1.ethermine.org:4444" -FS "us1.ethermine.org:4444" -O "$MY_ADDRESS.$MY_RIG"

# Claymore's Dual Ethereum+Decred AMD+NVIDIA GPU Miner
# https://github.com/nanopool/Claymore-Dual-Miner
#~/claymore-dual-miner/ethdcrminer64 -epool "eu1.ethermine.org:4444" -ewal "$MY_ADDRESS.$MY_RIG" -epsw x -mode 1 -ftime 10 -mport 0


#
# Monero Mining
#

# XMR-Stak - Monero/Aeon All-in-One Mining Software
# https://github.com/fireice-uk/xmr-stak
#cd ~/monero-mining
# CUDA (GPU) only mining. Disable the CPU miner backend.
#~/monero-mining/xmr-stak/build/bin/xmr-stak --noCPU
# CPU only mining. Disable the NVIDIA miner backend.
#~/monero-mining/xmr-stak/build/bin/xmr-stak --noNVIDIA


#
# Zcash Mining
#

# EWBF's CUDA Zcash Miner
# https://bitcointalk.org/index.php?topic=1707546.0
#cd ~/zcash-mining
#~/zcash-mining/ewbf/miner --fee 0 --server eu1-zcash.flypool.org --user YOUR-ZCASH-T-ADDRESS --pass x --port 3333



while :
do
        echo "Press [CTRL+C] to stop.."
        sleep 1

#~/miner/klaust/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://pool.bsod.pw:2030 -u $MY_ADDRESS_RAP.$MY_RIG -p c=RAP -R 5
#~/miner/klaust/ccminer-run -i 20 -r 0  -a neoscrypt -o stratum+tcp://pool.bsod.pw:1997 -u $MY_ADDRESS_GOA.$MY_RIG -p c=GOA
#~/miner/klaust/ccminer-run -r 0 -i 20 -a neoscrypt -o stratum+tcp://pool1.phi-phi-pool.net:4233 -u $MY_ADDRESS_PXC.$MY_RIG -p c=PXC
#~/miner/tpruvot/ccminer-run -r 0 -i 26.2 -a lyra2z  -o stratum+tcp://pool1.phi-phi-pool.net:4233 -u $MY_ADDRESS_PXC.$MY_RIG -p c=PXC
#~/miner/tpruvot/ccminer-run -r 0  -a neoscrypt -o stratum+tcp://pool.bsod.pw:1997 -u $MY_ADDRESS_GOA.$MY_RIG -p c=GOA
#~/miner/alexis78/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://pool.bsod.pw:2030 -u $MY_ADDRESS_RAP.$MY_RIG -p c=RAP -R 5
#~/miner/alexis78/ccminer-run -r 0 -a c11 -o stratum+tcp://hashfaster.com:3573 -u $MY_ADDRESS_SPD.$MY_RIG -p c=SPD
#~/miner/tpruvot/ccminer-run -r 0 -a lyra2z -o stratum+tcp://pool.bsod.pw:2132 -u $MY_ADDRESS_PBS.$MY_RIG -p c=PBS
#~/miner/djm34/ccminer-msvc2015/ccminer -i 19 -r 0 -a lyra2z -o stratum+tcp://pool.bsod.pw:2132 -u $MY_ADDRESS_PBS.$MY_RIG -p c=PBS
#~/miner/tpruvot/ccminer-run -r 0 -a skein -o stratum+tcp://pool.bsod.pw:2134 -u $MY_ADDRESS_ARGO.$MY_RIG -p c=ARGO
#~/miner/nemosminer/ccminer-run -r 0 -a skein -o stratum+tcp://pool.bsod.pw:2134 -u $MY_ADDRESS_ARGO.$MY_RIG -p c=ARGO
#~/miner/klaust/ccminer-run -r 0 -a skein -o stratum+tcp://pool.bsod.pw:2134 -u $MY_ADDRESS_ARGO.$MY_RIG -p c=ARGO
#~/miner/klaust/ccminer-run -i 20  -a neoscrypt -o stratum+tcp://pool.bsod.pw:1995 -u $MY_ADDRESS_SPK.$MY_RIG -p c=SPK -R 5
#~/miner/klaust/ccminer-run -i 20  -a neoscrypt -o stratum+tcp://pool.bsod.pw:2140 -u $MY_ADDRESS_DIN.$MY_RIG -p c=DIN -R 5
#~/miner/klaust/ccminer-run -i 20  -a neoscrypt -o stratum+tcp://lycheebit.com:4233 -u $MY_ADDRESS_NIHL.$MY_RIG -p c=NIHL,d=512
#~/miner/klaust/ccminer-run -i 20  -a neoscrypt -o stratum+tcp://yiimp.fatpanda.club:4233 -u $MY_ADDRESS_NIHL.$MY_RIG -p c=NIHL,d=512
#~/miner/klaust/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://tiny-pool.com:4233 -u $MY_ADDRESS_CROP.$MY_RIG -p c=CROP,d=512
#~/miner/klaust/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://hashfaster.com:4233 -u $MY_ADDRESS_CROP.Rig1080 -p c=CROP,d=1024
#~/miner/klaust/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://yiimp.gos.cx:4237 -u $MY_ADDRESS_NIHL.Rig1070 -p c=NIHL
#~/miner/klaust/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://tiny-pool.com:4234 -u $MY_ADDRESS_END.$MY_RIG -p c=END
#~/miner/klaust/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://pool1.phi-phi-pool.com:4233 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/klaust/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://tiny-pool.com:4233 -u $MY_ADDRESS_CROP.Rig1080 -p c=CROP,d=1048
#~/miner/klaust/ccminer-run -i 20  -a neoscrypt -o stratum+tcp://mpos-pools.com:3609 -u viatoro.$MY_RIG -p password
#~/miner/klaust/ccminer-run -i 20 -a neoscrypt -o stratum+tcp://eu1.altminer.net:10005 -u $MY_ADDRESS_ONEX.$MY_RIG -p c=ONEX
#~/miner/tpruvot/ccminer-run  -a skunk -o stratum+tcp://pool.bsod.pw:1998 -u $MY_ADDRESS_MUN.$MY_RIG -p c=MUN -R 5
#~/miner/216k155/ccminer-run -R 5 -i 22 -a nist5 -o stratum+tcp://pool.bsod.pw:3833 -u $MY_ADDRESS_BWK.$MY_RIG -p c=BWK --cpu-priority 5
#~/miner/MSFTserver/ccminer-run -R 5 -i 23 -a phi -o stratum+tcp://kwchmining.com:6667 -u $MY_ADDRESS_FLM.$MY_RIG -p c=FLM --cpu-priority 5

#~/miner/216k155/ccminer-run -i 22 -a lyra2v2 -o stratum+tcp://stratum.gos.cx:4502 -u $MY_ADDRESS_ABS.$MY_RIG -p c=ABS,d=128
#~/miner/alexis78/ccminer-run -a lyra2v2 -o stratum+tcp://stratum.gos.cx:4502 -u $MY_ADDRESS_ABS.$MY_RIG -p c=ABS,d=128
#~/miner/tpruvot/ccminer-run -r 0 -i 22 -a phi -o stratum+tcp://pool.bsod.pw:6667 -u $MY_ADDRESS_LUX.$MY_RIG -p c=LUX
#~/miner/tpruvot/ccminer-run -r 0 -i 22  -a lyra2v2 -o stratum+tcp://pool1.phi-phi-pool.com:4533 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/tpruvot/ccminer-run -r 0 -i 28 -a neoscrypt -o stratum+tcp://stratum.gos.cx:4241 -u $MY_ADDRESS_ARHM.$MY_RIG -p c=ARHM
#~/miner/klaust/ccminer-run -r 0 -i 23 -a neoscrypt -o stratum+tcp://stratum.gos.cx:4241 -u $MY_ADDRESS_ARHM.$MY_RIG -p c=ARHM
#~/miner/tpruvot/ccminer-run -r 0 -a phi -o stratum+tcp://eu2.bsod.pw:6667 -u $MY_ADDRESS_LUX.$MY_RIG -p c=LUX
#~/miner/alexis78/ccminer-run -a lyra2v2 -o stratum+tcp://stratum.gos.cx:4501 -u $MY_ADDRESS_KREDS.$MY_RIG -p c=KREDS,d=128
#~/miner/tpruvot/ccminer-run -r 0 -i 22  -a lyra2v2 -o stratum+tcp://stratum.gos.cx:4502 -u $MY_ADDRESS_ABS.$MY_RIG -p c=ABS,d=128
#~/miner/alexis78/ccminer-run -r 0 -a skein -o stratum+tcp://pool.bsod.pw:2151 -u $MY_ADDRESS_FRM.$MY_RIG -p c=FRM

#~/miner/tpruvot/ccminer-run -r 0 -a tribus -o stratum+tcp://stratum.gos.cx:8500 -u $MY_ADDRESS_SCRIV.$MY_RIG -p c=SCRIV
#~/miner/tpruvot/ccminer-run -r 0 -a tribus -o stratum+tcp://eu1.arcpool.com:1702 -u $MY_ADDRESS_VRT.$MY_RIG -p c=VRT
#~/miner/alexis78/ccminer-run -r 0 -a skein -o stratum+tcp://stratum.gos.cx:4937 -u $MY_ADDRESS_ENIX.$MY_RIG -p c=ENIX
#~/miner/tpruvot/ccminer-run -R 5  -a hmq1725 -o stratum+tcp://pool.cryptopros.us:3747 -u $MY_ADDRESS_ESP.$MY_RIG -p c=ESP --cpu-priority 5
#~/miner/tpruvot/ccminer-run -R 5 -i 20  -a hmq1725 -o stratum+tcp://hmq1725.mine.zpool.ca:3747 -u $MY_ADDRESS_ESP -p c=ESP,d=6134 --cpu-priority 5
#~/miner/MSFTserver/ccminer-run -R 5 -i 20  -a x16r -o stratum+tcp://ravenminer.com:3366 -u $MY_ADDRESS_RVN.$MY_RIG -p c=RVN
#####################################################################################
#~/miner/klaust/ccminer-run -i 17 -a neoscrypt -o stratum+tcp://pool1.phi-phi-pool.com:4233 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/ccminer-xevan/ccminer-run -r 0 -a xevan -o stratum+tcp://pool1.phi-phi-pool.com:3739 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/tpruvot/ccminer-run -r 0  -a x17 -o stratum+tcp://pool1.phi-phi-pool.com:3737 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/krnlx/ccminer-run -r 0 -a xevan -o stratum+tcp://pool1.phi-phi-pool.com:3739 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/tpruvot/ccminer-run -r 0  -a keccakc -o stratum+tcp://pool1.phi-phi-pool.com:5134 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/tpruvot/ccminer-run -r 0 -i 28  -a neoscrypt -o stratum+tcp://pool1.phi-phi-pool.com:4233 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/tpruvot/ccminer-run -r 0 -i 28  -a neoscrypt -o stratum+tcp://neoscrypt.mine.zpool.ca:4233 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/klaust/ccminer-run -i 23 -r0 -a neoscrypt -o stratum+tcp://neoscrypt.mine.zpool.ca:4233 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/alexis78/ccminer-run -r 0 -a c11 -o stratum+tcp://pool1.phi-phi-pool.com:3573 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/alexis78/ccminer-run -r 0  -a nist5 -o stratum+tcp://pool1.phi-phi-pool.com:3833 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/alexis78/ccminer-run -r 0 -a nist5 -o stratum+tcp://nist5.mine.zpool.ca:3833 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/ccminer-xevan/ccminer-run -r 0 -a nist5 -o stratum+tcp://nist5.mine.zpool.ca:3833 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/tpruvot/ccminer-run -r 0 -i 22  -a lyra2v2 -o stratum+tcp://pool1.phi-phi-pool.com:4533 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/tpruvot/ccminer-run -r 0 -i 22  -a lyra2v2 -o stratum+tcp://pool1.phi-phi-pool.com:4533 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC
#~/miner/tpruvot/ccminer-run -r 0  -a tribus -o stratum+tcp://pool1.phi-phi-pool.com:8533 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC

#~/miner/MSFTserver/ccminer-run -R 5 -i 23 -a phi -o stratum+tcp://phi.mine.ahashpool.com:8333 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC --cpu-priority 5
#~/miner/216k155/ccminer-run -R 5 -a x17 -o stratum+tcp://x17.mine.ahashpool.com:3737 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTC --cpu-priority 5
##########################################

#~/claymore-dual-miner/ethdcrminer64 -epool us-east.ethash-hub.miningpoolhub.com:12020 -ewal $MY_ADDRESS_POOL_HUB.$MY_RIG -eworker $MY_ADDRESS_POOL_HUB.$MY_RIG -esm 3 -epsw x -allcoins 1 -retrydelay -1
#~/ethereum-mining/ethminer/build/ethminer/ethminer --farm-retries 0 -U  -S us-east.ethash-hub.miningpoolhub.com:12020 -O $MY_ADDRESS_POOL_HUB.$MY_RIG:x -FS exit
#~/bminer-v6.1.0-7ea8bbe/bminer -uri stratum+ssl://$MY_ADDRESS_POOL_HUB.$MY_RIG@us-east.equihash-hub.miningpoolhub.com:12023 -max-network-failures=0 -watchdog=false
#~/miner/tpruvot/ccminer-run -r 0 -a myr-gr -o stratum+tcp://hub.miningpoolhub.com:12005 -u $MY_ADDRESS_POOL_HUB.$MY_RIG -p x
#~/miner/alexis78/ccminer-run -r 0 -a skein -o stratum+tcp://hub.miningpoolhub.com:12016 -u $MY_ADDRESS_POOL_HUB.$MY_RIG -p x
#~/miner/alexis78/ccminer-run -r 0 -a lyra2v2 -o stratum+tcp://hub.miningpoolhub.com:12018 -u $MY_ADDRESS_POOL_HUB.$MY_RIG -p x
#~/miner/djm34/ccminer-run -r 0 -i 20 -a lyra2z -o stratum+tcp://asia.lyra2z-hub.miningpoolhub.com:12025 -u $MY_ADDRESS_POOL_HUB.$MY_RIG -p x --cpu-priority 5
#~/miner/djm34/ccminer-run -i 20 -a lyra2z -o stratum+tcp://asia.lyra2z-hub.miningpoolhub.com:20581 -u $MY_ADDRESS_POOL_HUB.$MY_RIG -p x --cpu-priority 5
##############################
#~/buildMiner/ocminer/ccminer-run -r 0 -a x16r -o stratum+tcp://rvn.suprnova.cc:6667 -u $MY_ADDRESS_POOL_SUPRNOVA.$MY_RIG -p x
~/buildMiner/ocminer/ccminer-run -r 0 -a x16r -o stratum+tcp://stratum.gos.cx:3639 -u $MY_ADDRESS_XMN.$MY_RIG -p c=XMN
#~/buildMiner/alexis78/ccminer-run -r 0 -i 20  -a x17 -o stratum+tcp://xvg-x17.suprnova.cc:7477 -u $MY_ADDRESS_POOL_SUPRNOVA.$MY_RIG -p x
#~/buildMiner/alexis78/ccminer-run -R 5 -i 22 -a c11 -o stratum+tcp://pool.bsod.pw:2143 -u $MY_ADDRESS_SPD.$MY_RIG -p c=SPD
#~/buildMiner/alexis78/ccminer-run -r 0 -i 28  -a neoscrypt -o stratum+tcp://neoscrypt.mine.zpool.ca:4233 -u $MY_ADDRESS_BTC.$MY_RIG -p c=BTCdone
