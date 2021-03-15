#!/bin/sh

set -e
set -x

ip link add dev wg0 type wireguard
ip address add dev wg0 $WG_IP

wg set wg0 \
  private-key /root/wg-private-key \
  peer $WG_ENDPOINT_KEY \
  allowed-ips $WG_ALLOWED_IPS \
  endpoint $WG_ENDPOINT_HOST \
  persistent-keepalive 25
ip link set up dev wg0

wg show wg0 public-key

interface_ip=`ip -f inet addr show wg0 | grep -Po 'inet \K[\d.]+'`
echo $WG_ALLOWED_IPS | tr ',' '\n' | while read ip; do
    ip route replace $ip via $interface_ip
done

iptables -t filter -A FORWARD -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE