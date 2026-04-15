#!/bin/sh

echo "Starting Tor..."
tor -f /etc/tor/torrc &

# 等待 Tor 完全啟動（Bootstrapped 100%）
echo "Waiting for Tor to bootstrap..."
for i in $(seq 1 120); do
    if grep -q "Bootstrapped 100%" /var/log/tor/log 2>/dev/null; then
        echo "Tor bootstrapped successfully!"
        break
    fi
    sleep 5
done

if ! grep -q "Bootstrapped 100%" /var/log/tor/log 2>/dev/null; then
    echo "ERROR: Tor failed to bootstrap after 10 minutes!"
    tail -n 50 /var/log/tor/log
    exit 1
fi

echo "Starting Xray..."
/xray -config /xray.json &

echo "Starting Caddy..."
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
