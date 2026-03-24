#!/bin/bash
env=${1:-publish_xrx}
processid=${2:-2}
svrtype=${3:-Manager}

script_root=/home/tlbb_spug/${svrtype}_${processid}/Script
scene_config=/home/tlbb_spug/${svrtype}_${processid}/Scene

if [ "$svrtype" != "Manager" ] && [ "$svrtype" != "Game" ]; then
    script_root=/home/tlbb_spug/Game2/Script
    scene_config=/home/tlbb_spug/Game2/Scene
fi

echo "=== RUN $svrtype node $processid (env=$env) ==="

cd framework && make clean && make linux && cd ..
make clean && make

mkdir -p cservice lualib services
cp framework/cservice/*.so cservice/ 2>/dev/null || true
cp -r framework/lualib/* lualib/ 2>/dev/null || true

exec_target=${svrtype}_tlbb_${processid}
pkill -f "$exec_target" 2>/dev/null || true

cp framework/skynet framework/$exec_target
chmod +x framework/$exec_target

# GỌI ĐÚNG 5 THAM SỐ - FIX config_maker.lua
lua config_maker.lua "$env" "$script_root" "$processid" "$svrtype" "$scene_config" > config

ulimit -c unlimited
./framework/$exec_target config

echo "start server ok in env = $env, processid = $processid"