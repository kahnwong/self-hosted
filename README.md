# self-hosted setup

Notes: do not use snap docker. It has mount permission issues.

## Instructions

1. Setup env via nix: <https://github.com/kahnwong/nix>
2. Setup Kubernetes: <https://github.com/kahnwong/k8s-playground>
3. Setup duckdns
4. Set wallabag's graby site config
5. Spin up docker-composes
6. `chmod -R 0755 /opt/`
7. `tailscale up`

## Snippets

### Use docker without sudo

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

### Auto mount storage

```bash
# sudo nano /etc/fstab
UUID=D424912B2491119A /mnt/media ntfs-3g uid=1000,gid=1000,nofail,umask=0 0 0

# for vfat with utf8 support
UUID=1B18-1165 /mnt/media vfat iocharset=utf8,uid=1000,gid=1000,nofail,umask=0 0 0
```

### Caddy

```bash
$ systemctl reload caddy
$ caddy hash-password --algorithm bcrypt # create password hash
```

## crontab

```bash
PATH=/usr/bin

*/1 * * * * "$HOME"/ddns/cloudflare.sh >/dev/null 2>&1

PATH=/usr/bin:/home/kahnwong/.nix-profile/bin
0 5 * * * "$HOME"/Git/kahnwong/self-hosted/scripts/daily_cleanup.sh > /dev/null 2>&1
```
