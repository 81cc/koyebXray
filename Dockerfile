FROM alpine:3.23

ARG AUUID="31034190-cfde-47c0-98fc-b71416d3c97a"
ARG PORT=8080

ADD etc/Caddyfile /tmp/Caddyfile
ADD etc/xray.json /tmp/xray.json
ADD start.sh /start.sh

RUN apk update && \
    apk add --no-cache ca-certificates caddy wget unzip && \
    wget -O Xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip Xray-linux-64.zip && \
    chmod +x /xray && \
    rm -rf /var/cache/apk/* Xray-linux-64.zip && \
    mkdir -p /etc/caddy /usr/share/caddy && \
    echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt && \
    wget https://github.com/AYJCSGM/mikutap/archive/master.zip -O /tmp/index.zip && \
    unzip -qo /tmp/index.zip -d /usr/share/caddy/ && \
    mv /usr/share/caddy/mikutap-master/* /usr/share/caddy/ && \
    rm -rf /tmp/index.zip && \
    cat /tmp/Caddyfile | sed -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile && \
    cat /tmp/xray.json | sed -e "s/\$AUUID/$AUUID/g" -e "s/\$ParameterSSENCYPT/chacha20-ietf-poly1305/g" >/xray.json && \
    chmod +x /start.sh

CMD ["/start.sh"]
