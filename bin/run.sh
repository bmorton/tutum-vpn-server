#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

while ! ifconfig -s | grep "ethwe"; do
  echo "Waiting for ethwe..."
  sleep 1
done
echo "ethwe is up!"


SSH_OPTS="-p 2222 -o ConnectTimeout=4 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
my_public_ip=`dig -4 @ns1.google.com -t txt o-o.myaddr.l.google.com +short | sed "s/\"//g"`

# Change root password
if [ "${VPN_PASSWORD}" == "**ChangeMe**" ]; then
   export VPN_PASSWORD=`pwgen -s 20 1`
fi

prepare-ssh.sh
prepare-vpn.sh

echo "==========================================="
echo "To generate an OpenVPN client configuration file, execute this command from your machine:"
echo "sshpass -p ${VPN_PASSWORD} ssh $SSH_OPTS root@$my_public_ip \"get_vpn_client_conf.sh $my_public_ip:1194\" > docker_cloud_vpn_client.ovpn"
echo "==========================================="

/usr/bin/supervisord
