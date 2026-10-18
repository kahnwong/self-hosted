# KubeVirt

## Usage

```bash
# list vms
kubectl get vms

# start vm
virtctl start vm

# stop vm
virtctl stop vm
```

Access via

```bash
virtctl ssh ubuntu@vm/dev-vm -n vms -i ~/.ssh/kubevirt-dev-ubuntu
```
