# Forgejo

ci instructions:

- <https://forgejo.org/2023-02-27-forgejo-actions/>
- <https://code.forgejo.org/forgejo/runner>

## Forgejo

```bash
kubectl create namespace forgejo
helm upgrade --install forgejo ../default/base --values forgejo.yaml --namespace forgejo
```

## Runner

Enable `actions` in a repo, then under site administration, `create new runner` then run following:

```bash

export FORGEJO_HOST=
export TOKEN=

wget -O forgejo-runner https://code.forgejo.org/forgejo/runner/releases/download/v3.0.0/forgejo-runner-3.0.0-linux-amd64
chmod +x forgejo-runner
./forgejo-runner register
./forgejo-runner daemon
```
