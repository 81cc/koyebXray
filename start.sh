#!/bin/sh

echo "=== Starting Xray + Caddy (Tor 已關閉) ==="

# 使用你原本的 UUID
UUID="31034190-cfde-47c0-98fc-b71416d3c97a"

echo "替換 UUID 到 xray.json ..."
sed -i "s/\$AUUID/$UUID/g" /xray.json

echo "=== 啟動 Xray ==="
/xray -config /xray.json &

echo "等待 Xray 啟動 8 秒..."
sleep 8

echo "=== 啟動 Caddy ==="
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
