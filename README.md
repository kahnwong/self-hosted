# self-hosted setup

Notes: do not use snap docker. It has mount permission issues.

## Instructions

1. Setup env via nix: <https://github.com/kahnwong/nix>
2. Setup Kubernetes: <https://github.com/kahnwong/k8s-playground>
3. Setup ddns cron. [Source](https://github.com/K0p1-Git/cloudflare-ddns-updater/blob/main/cloudflare-template.sh)
4. `tailscale up`
5. Install caddy via xcaddy + cloudflare plugin: <https://docs.karnwong.me/knowledge-base/ops/tools/networking/caddy#caddy-with-cloudflare-plugin>
6. Install headscale: <https://headscale.net/stable/setup/install/official/#using-packages-for-debianubuntu-recommended>. Edit following config keys: `server_url, listen_addr, base_domain`. Add `sudo usermod -aG headscale $USER` to allow invoking headscale without sudo.

## Update caddy helper script

Place this file at `$HOME`.

```bash
#!/bin/bash

cd self-hosted
./scripts/caddy_reload.sh
```

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
