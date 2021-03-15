#!/bin/sh

set -e
set -x

sh /root/wg.sh

dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml