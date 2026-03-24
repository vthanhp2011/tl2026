#!/bin/bash
set -e

echo "=== BẮT ĐẦU BUILD & RUN tl2026 ==="

# Build tất cả 3 node (Game2, Span4, Tool6)
for dir in Game2 Span4 Tool6; do
#for dir in Game2; do
    echo "Building $dir..."
    cd "$dir"
    make clean || true
    make -j4
    cd ..
done

echo "=== BUILD XONG ==="

# Chạy 3 node (background)

# Game2 - Manager node
cd /home/tlbb_spug/Game2
./r.sh debug 2 Game
sleep 3

# Span4 - Scene node
cd /home/tlbb_spug/Span4
./r.sh debug 4 Span
sleep 3

# Tool6 - Tool node
cd /home/tlbb_spug/Tool6
./r.sh debug 6 Tool

echo "=== SERVER ĐANG CHẠY ==="
echo "Game2 (node 2) - Span4 (node 4) - Tool6 (node 6)"
echo "Dừng tất cả: killall skynet hoặc dùng stop.exp"
