FROM debian:bullseye

RUN apt-get update -qq && apt-get upgrade -y

RUN apt-get install -y wireguard \
  dnscrypt-proxy \
  net-tools \
  iproute2 \
  inetutils-ping \
  ca-certificates \
  dnsutils \
  iptables

ADD ./dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
ADD ./wg.sh /root/wg.sh
ADD ./run.sh /root/run.sh

ENV WG_IP=
ENV WG_ENDPOINT_KEY=
ENV WG_ENDPOINT_HOST=
ENV WG_ALLOWED_IPS=

CMD ["/root/run.sh"]