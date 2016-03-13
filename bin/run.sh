#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

while ! ifconfig -s | grep "ethwe"; do
  echo "Waiting for ethwe..."
  sleep 1
done
echo "ethwe is up!"


my_public_ip=`dig -4 @ns1.google.com -t txt o-o.myaddr.l.google.com +short | sed "s/\"//g"`
prepare-vpn.sh

/usr/sbin/openvpn --cd /etc/openvpn --config server.conf
