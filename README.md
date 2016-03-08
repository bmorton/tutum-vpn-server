# Docker Cloud OpenVPN server

## Launch a VPN-server service in Docker Cloud

```
docker-cloud service run -n vpn-server -p 2222:2222 -p 1194:1194 -e DEBUG=1 --privileged \
  --link-service myservice:myservice \
  bmorton/vpn-server
```

## Retrieve the OpenVPN client configuration

```
docker-cloud exec CONTAINER_UUID get_vpn_client_conf.sh YOUR_SERVICE_IP_OR_DNS:1194 > docker.ovpn
```
