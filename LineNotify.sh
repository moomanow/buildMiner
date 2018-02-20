#!/bin/bash

# CCMiner Linux Line Notify 
# By Somchai Noodat 
# Email: bi@binaryline.co.th 
# Line id : bigon2 
# Version 0.01 20170729
# Require screen curl jq
#	$sudo apt-get install curl jq screen
# How to use: 
#      screen -dmS line bash ./CCMiner_LineNotify
#      screen -r line 
#Config
if ! source ~/settings.conf; then
        echo "FAILURE: Can not load global settings 'settings.conf'"
        exit 9
fi

LINE_TOKEN="$MY_LINE_ID" #Line Token ID
LINE_MINER="$MY_RIG"
MINER_API="localhost 4068"
NOTIFY_LOOP_MINUTE="30" # Send notify every 30 minutes


##----Don't edit after this line---------------------------
if [ -z "${LINE_TOKEN}" ]; then
    echo "LINE_TOKEN is not set,exit!!"
    exit
fi
LINE_NEWLINE=$'\n'
CEL="C" 
TIME_LOOP=$[NOTIFY_LOOP_MINUTE*60]
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "$(date) - waiting 90 seconds " 
echo ""
#sleep 90

while :
do
	echo "$(date) - Starting miner line notify script." 
	API_STAT=$( echo 'threads' | nc $MINER_API  )
	LINE_MSG="CCMiner Miner name:$LINE_MINER $LINE_NEWLINE"
	GPU_TOTAL=0
	GPU_COUNT=5
        GPU_POWER_TOTAL=0
	GPU_SPEED_STAT=0
	
	#IFS='|' read -ra API_STATS <<< "$API_STAT"
	GPU_COUNT=5
	
	for (( idx=0; idx<=$GPU_COUNT-1; idx++ )) 
	do
    	GPU_ID=$idx
    	#GPU_SPEED=0 
	#	GPU_SPEED=$(echo "${API_STATS[$idx]}" | awk -v RS=';' -F'=' '$1=="KHS" {print $2}')
	#	GPU_SPEED=$(echo "scale=3;$GPU_SPEED/1000" | bc )
    	#GPU_TOTAL=$(echo "scale=3;$GPU_TOTAL+$GPU_SPEED" | bc)
    	##Read from nvidia-smi
    	{ IFS=', ' read CURRENT_TEMP CURRENT_FAN POWERDRAW PWRLIMIT; } < <(nvidia-smi -i $GPU_ID --query-gpu=temperature.gpu,fan.speed,power.draw,power.limit --format=csv,noheader,nounits)
		GPU_TEMP=$CURRENT_TEMP
		GPU_POWER=$POWERDRAW
		GPU_POWER_TOTAL=$( echo "scale=0;$GPU_POWER_TOTAL+$GPU_POWER"|bc)
		LINE_MSG+="GPU#$GPU_ID, $GPU_SPEED Mh/s, $GPU_TEMP $CEL, FAN $CURRENT_FAN%, $GPU_POWER W$LINE_NEWLINE"
    		#echo "$LINE_MSG"
	done
  	#LINE_MSG+="Total Speed:$GPU_TOTAL Mh/s$LINE_NEWLINE"
   	LINE_MSG+="Total Power:$GPU_POWER_TOTAL W $LINE_NEWLINE"
	echo "$LINE_MSG"
	curl -sS -X POST https://notify-api.line.me/api/notify \
		-H "Authorization: Bearer $LINE_TOKEN" \
		-F "message=$LINE_MSG" > /tmp/line.log  

	echo "Sleep for $NOTIFY_LOOP_MINUTE minute(s)$LINE_NEWLINE"
	sleep $TIME_LOOP
done

