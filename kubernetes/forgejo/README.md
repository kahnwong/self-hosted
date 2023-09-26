# Forgejo

ci instructions:
- <https://forgejo.org/2023-02-27-forgejo-actions/>

## Forgejo
```bash
kubectl create namespace forgejo
helm upgrade --install forgejo ../default/base --values forgejo.yaml --namespace forgejo
```

## Runner

Enable `actions` in a repo, then under site administration, `create new runner` then run following:

```bash
sudo apt update
sudo apt install make golang docker.io -y

sudo groupadd docker
sudo usermod -aG docker $USER

export FORGEJO_HOST=
export TOKEN=

git clone https://codeberg.org/forgejo/runner
cd runner
git checkout v1.1.0
make build
./forgejo-runner register --name myrunner --no-interactive --instance $FORGEJO_HOST --token $TOKEN
./forgejo-runner daemon
```
