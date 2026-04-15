#!/bin/sh

echo "=== Starting Xray + Caddy on Apply.Build ==="

echo "=== Starting Xray ==="
/xray -config /xray.json &

sleep 8

echo "=== Starting Caddy on port 8080 ==="
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
