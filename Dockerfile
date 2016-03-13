FROM ubuntu:14.04
MAINTAINER Brian Morton <brian@xq3.net>

RUN apt-get update && \
    apt-get install -y openvpn openvpn-auth-ldap easy-rsa iptables rsync ipcalc dnsutils ca-certificates

ENV VPN_PATH /etc/openvpn
ENV DEBUG 0

WORKDIR /etc/openvpn

RUN mkdir -p /usr/local/bin
ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh

VOLUME ["/etc/openvpn"]
EXPOSE 1194
CMD ["/usr/local/bin/run.sh"]
