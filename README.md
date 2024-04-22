# self-hosted setup

Notes: do not use snap docker. It has mount permission issues.

## Instructions

1. Setup env via nix: <https://github.com/kahnwong/nix>
2. Setup Kubernetes: <https://github.com/kahnwong/k8s-playground>
3. Setup ddns cron
4`tailscale up`


## crontab

```bash
PATH=/usr/bin

*/1 * * * * "$HOME"/ddns/cloudflare.sh >/dev/null 2>&1

PATH=/usr/bin:/home/kahnwong/.nix-profile/bin
0 5 * * * "$HOME"/Git/kahnwong/self-hosted/scripts/daily_cleanup.sh > /dev/null 2>&1
```
