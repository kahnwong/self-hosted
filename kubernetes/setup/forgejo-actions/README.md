# Forgejo Actions

<https://forgejo.org/docs/latest/admin/actions/>

## Pre-Reqs

Install docker

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
# shellcheck disable=SC1091
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Install Runner

```bash
export ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')
export RUNNER_VERSION=$(curl -X 'GET' https://data.forgejo.org/api/v1/repos/forgejo/runner/releases/latest | jq .name -r | cut -c 2-)
export FORGEJO_URL="https://code.forgejo.org/forgejo/runner/releases/download/v${RUNNER_VERSION}/forgejo-runner-${RUNNER_VERSION}-linux-${ARCH}"
wget -O forgejo-runner ${FORGEJO_URL} || curl -o forgejo-runner ${FORGEJO_URL}
chmod +x forgejo-runner
wget -O forgejo-runner.asc ${FORGEJO_URL}.asc || curl -o forgejo-runner.asc ${FORGEJO_URL}.asc

sudo cp forgejo-runner /usr/local/bin/forgejo-runner
sudo useradd --create-home runner
sudo usermod -aG docker runner

sudo -i
forgejo-runner generate-config > /home/runner/runner-config.yml # then edit it. follow <https://forgejo.org/docs/latest/admin/actions/registration/#interactive-registration>
```

Add systemd:

```bash
# sudo vi /etc/systemd/system/forgejo-runner.service

[Unit]
Description=Forgejo Runner
Documentation=https://forgejo.org/docs/latest/admin/actions/
After=docker.service

[Service]
ExecStart=/usr/local/bin/forgejo-runner daemon -c /home/runner/runner-config.yml
ExecReload=/bin/kill -s HUP $MAINPID

# This user and working directory must already exist
User=runner
WorkingDirectory=/home/runner
Restart=on-failure
# allow configured shutdown_timeout to be effective, rather than overridden by systemd
TimeoutStopSec=infinity
RestartSec=10

[Install]
WantedBy=multi-user.target
```
