# Headscale

Config is stored at `/etc/headscale/config.yaml`

## Usage

```bash
# [server] add user
headscale users create $USER

# [client] connect to headscale
curl -fsSL https://tailscale.com/install.sh | sh
tailscale up --login-server $HEADSCALE_URL

# [server] list users
headscale users list

# [server] list nodes
headscale nodes list
```
