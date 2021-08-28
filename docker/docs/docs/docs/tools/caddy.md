---
title: Caddy
---

```bash
# log location
/var/lib/caddy/.local/share/caddy
```

## Filter IP
```python title="Caddyfile"
# https://gist.github.com/morph027/b771fb579c36ae550ebb2764581a1d0e

intranet.example.com {
  @ipfilter {
    not remote_ip 192.168.0.0/16
  }
  route @ipfilter {
    # redirect
    redir https://example.com/
    # or respond
    # respond "Access denied" 403 {
    #   close
    # }
  }
  reverse_proxy / https://intranet.lan
}
```
