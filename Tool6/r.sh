#!/bin/bash
env=$1
processid=$2
svrtype=$3

if  [ ! -n "$svrtype" ] ;then
    svrtype="Game"
fi
if [ "$svrtype" = "Game" ]; then
script_root=/home/ubuntu/tlbb_spug/${svrtype}_${processid}/Script
scene_config=/home/ubuntu/tlbb_spug/${svrtype}_${processid}/Scene
else
script_root=/home/ubuntu/tlbb_spug/Game_2/Script
scene_config=/home/ubuntu/tlbb_spug/Game_2/Scene
fi
port=$((6000 + processid))
TCPListeningnum=`netstat -an | egrep ":${port}" | awk '$1 == "tcp" && $NF == "LISTEN" {print $0}' |wc -l`
echo "TCPListeningnum =" $TCPListeningnum
if [ "$svrtype" = "Game" ] && [ $TCPListeningnum -gt 0 ] ;then
    chmod +x nc.sh
    chmod +x stop.exp
    ./stop.exp $port
    if [ "$env" = "debug" ] ;then
        sleep 5s
    else
        sleep 60s
    fi
fi
cd framework && make linux && cd ..
make
exec_target=$svrtype"_tlbb_"$processid
echo "target =" $exec_target
ID=`ps -ef | grep "$exec_target" | grep -v '$0' | grep -v "grep" | awk '{print $2}'`
echo "pid =" $ID
for id in $ID
do
sudo kill $id
echo "killed $id"
done
cp ./framework/skynet ./framework/$exec_target
chmod +x ./framework/$exec_target
sleep 10s
lua config_maker.lua "$env" "$script_root" $processid "$svrtype" "$scene_config" > config
ulimit -c unlimited

./framework/$exec_target config
echo "start server ok in env = $env, processid = $processid"
