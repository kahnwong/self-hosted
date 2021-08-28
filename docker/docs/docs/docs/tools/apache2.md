---
title: apache2
---

https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04

### Password auth
```bash
$ sudo apt-get install apache2 apache2-utils
$ sudo htpasswd -c /etc/apache2/.htpasswd USER
```

### Add to vhost
```bash
<Directory "/var/www/rss-bridge">
    AuthType Basic
    AuthName "Restricted Content"
    AuthUserFile /etc/apache2/.htpasswd
    Require valid-user
</Directory>
```

Port mapping: `sudo nano /etc/apache2/ports.conf`
