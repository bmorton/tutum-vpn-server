#!/bin/bash

set -e

VPN_PATH=/etc/openvpn

# Extract remote nodes
VPN_SERVERS="$1"
if [ "${VPN_SERVERS}" == "**ChangeMe**" ] || [ -z ${VPN_SERVERS} ]; then
  VPN_SERVERS=${DOCKERCLOUD_SERVICE_FQDN}:1194
fi
OVPN_SERVERS=`echo ${VPN_SERVERS} | sed "s/^/remote /g" | sed "s/,$//g" | sed "s/,/\nremote /g" | sed "s/:/ /g"`

# Extract ca.crt
CA_CRT=`cat $VPN_PATH/easy-rsa/keys/ca.crt`
CLIENT_CRT=`cat $VPN_PATH/easy-rsa/keys/docker_cloud_vpn_client.crt`
CLIENT_KEY=`cat $VPN_PATH/easy-rsa/keys/docker_cloud_vpn_client.key`
TA_KEY=`cat $VPN_PATH/easy-rsa/keys/ta.key`

cat > $VPN_PATH/docker_cloud_vpn_client.ovpn <<EOF
$OVPN_SERVERS
remote-random
client
dev tun
proto tcp
resolv-retry infinite
nobind
comp-lzo

;user nobody
;group nogroup

;log-append  /var/log/openvpn.log
verb 3

persist-key
persist-tun

key-direction 1

<ca>
$CA_CRT
</ca>

<cert>
$CLIENT_CRT
</cert>

<key>
$CLIENT_KEY
</key>

<tls-auth>
$TA_KEY
</tls-auth>
EOF

chmod 600 $VPN_PATH/docker_cloud_vpn_client.ovpn
cat $VPN_PATH/docker_cloud_vpn_client.ovpn
