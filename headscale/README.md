# Headscale

Config is stored at `/etc/headscale/config.yaml`

## Install

<https://headscale.net/stable/setup/install/official/>

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

## Traffic passs-through for Mullvad

```bash
# apply
sudo nft -f mullvad_tailscale.rules

# remove
sudo nft delete table inet mullvad_tailscale

# tailscale up
sudo tailscale up --accept-dns=false
```
