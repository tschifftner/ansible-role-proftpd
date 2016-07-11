# Ansible Role: proftpd

[![Build Status](https://travis-ci.org/tschifftner/ansible-role-proftpd.svg?branch=master)](https://travis-ci.org/tschifftner/ansible-role-proftpd)

Installs proftpd on Debian/Ubuntu linux servers.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

### Open firewall

```
iptables -A OUTPUT -p tcp --sport 21 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 20 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 1024: --dport 1024: -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 20 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 1024: --dport 1024: -m state --state ESTABLISHED,RELATED,NEW -j ACCEPT
```  

_For tschifftner.firewall:_
```
firewall_additional_rules:
# allowing active/passive FTP
  - 'iptables -A OUTPUT -p tcp --sport 21 -m state --state ESTABLISHED -j ACCEPT'
  - 'iptables -A OUTPUT -p tcp --sport 20 -m state --state ESTABLISHED,RELATED -j ACCEPT'
  - 'iptables -A OUTPUT -p tcp --sport 1024: --dport 1024: -m state --state ESTABLISHED -j ACCEPT'
  - 'iptables -A INPUT -p tcp --dport 21 -m state --state NEW,ESTABLISHED -j ACCEPT'
  - 'iptables -A INPUT -p tcp --dport 20 -m state --state ESTABLISHED -j ACCEPT'
  - 'iptables -A INPUT -p tcp --sport 1024: --dport 1024: -m state --state ESTABLISHED,RELATED,NEW -j ACCEPT'
```

### Create password hash

```
ftpasswd --hash
```

# Debugging

SSL/TLS

```
openssl s_client -connect 127.0.0.1:21 -starttls ftp
```

```
sudo ssldump -d -k /etc/ssl/private/proftpd-certificate.key -i lo0 port 21
```