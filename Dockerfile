FROM debian:bullseye

RUN apt-get update -qq && apt-get upgrade -y

RUN apt-get install -y wireguard \
  dnscrypt-proxy \
  net-tools \
  iproute2 \
  inetutils-ping \
  ca-certificates

RUN apt-get install -y dnsutils

ADD ./dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml

CMD ["dnscrypt-proxy", "-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml"]
