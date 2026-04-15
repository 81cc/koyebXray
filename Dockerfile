# ... 原有內容 ...

RUN mkdir -p /etc/tor /var/log/tor /var/lib/tor && \
    echo "SocksPort 9050" > /etc/tor/torrc && \
    echo "Log notice file /var/log/tor/log" >> /etc/tor/torrc && \
    echo "DataDirectory /var/lib/tor" >> /etc/tor/torrc && \
    echo "ControlPort 9051" >> /etc/tor/torrc && \
    echo "CookieAuthentication 1" >> /etc/tor/torrc && \
    chmod -R 700 /var/lib/tor && \
    chown -R tor:tor /var/lib/tor /var/log/tor 2>/dev/null || true
