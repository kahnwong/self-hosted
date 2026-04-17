# Cilium

<https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#k8s-install-quick>

### K3S

```bash
sudo mount bpffs -t bpf /sys/fs/bpf
export MASTER_IP=$(ip a |grep global | grep -v '10.0.2.15' | awk '{print $2}' | cut -f1 -d '/')
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-backend=none --disable=traefik --node-external-ip=${MASTER_IP} --bind-address=${MASTER_IP}" sh -
```

```bash
## on local
cilium install --version 1.14.2
cilium hubble enable
cilium hubble enable --ui

# open ui
cilium hubble ui

# test hubble
## if pod fails run this on linux host
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512

while true; do cilium connectivity test; done
```
