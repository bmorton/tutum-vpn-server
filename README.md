# Docker Cloud OpenVPN server

## Launch a VPN-server service in Docker Cloud

```
docker-cloud service run -n vpn-server -p 1194:1194 --privileged \
  -e LDAP_URL=ldaps://ldap.example.org:636 \
  -e LDAP_BIND_DN=uid=Manager,ou=People,dc=example,dc=com \
  -e LDAP_PASSWORD=secret \
  -e LDAP_AUTHORIZATION_BASE_DN=ou=People,dc=example,dc=com \
  -e LDAP_AUTHORIZATION_SEARCH_FILTER=(uid=%u) \
  bmorton/vpn-server
```

## Retrieve the OpenVPN client configuration

```
docker-cloud container exec vpn-server-1 generate_ovpn > DockerCloud.ovpn
```

## JumpCloud plug!

If you'd like a simple, free, 10-user LDAP solution to use with this, check out [JumpCloud](https://www.jumpcloud.com)!  They also have [a guide for getting this setup](https://jumpcloud.com/engineering-blog/managing-openvpn/).

These are the settings you'd want to use with this image for JumpCloud:

```
LDAP_URL=ldaps://ldap.jumpcloud.com:636 \
LDAP_BIND_DN=uid=[YOUR-LDAP-BIND-USERNAME-PER-ABOVE],ou=Users,o=[YOUR-ORG-ID-PER-ABOVE],dc=jumpcloud,dc=com \
LDAP_PASSWORD=secret \
LDAP_AUTHORIZATION_BASE_DN=ou=users,o=[YOUR-ORG-ID-PER-ABOVE],dc=jumpcloud,dc=com \
LDAP_AUTHORIZATION_SEARCH_FILTER=(uid=%u) \
```
