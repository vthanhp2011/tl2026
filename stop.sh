#!/bin/bash
# stop.sh - Stop graceful + lưu hết data vào MySQL

if [ -z "$1" ]; then
    echo "Cách dùng: ./stop.sh <processid>"
    echo "Ví dụ: ./stop.sh 1     (console port sẽ là 6001)"
    exit 1
fi

processid=$1
port=$((6000 + processid))

echo "[$(date)] === STOP SERVER processid=$processid (console port=$port) ==="

# 1. Gửi lệnh close → trigger save player data vào MySQL
echo -e "call .logind \"close\"\ncall .gamed \"close\"\n" | nc 127.0.0.1 $port

echo "[$(date)] Đã gửi lệnh close. Chờ 15s để dbproxy save hết data..."
sleep 1

# 2. Kill process an toàn (chỉ khi tồn tại)
targets=("Game_tlbb_$processid" "Span4_tlbb_$processid" "Tool6_tlbb_$processid")

for exec_target in "${targets[@]}"; do
    ID=$(pgrep -f "$exec_target")
    if [ -n "$ID" ]; then
        for pid in $ID; do
            echo "[$(date)] Kill PID $pid ($exec_target)"
            sudo kill "$pid" 2>/dev/null
        done
    else
        echo "[$(date)] Không tìm thấy tiến trình $exec_target"
    fi
done

echo "[$(date)] Server đã stop hoàn toàn. Kiểm tra MySQL để confirm data đã lưu!"