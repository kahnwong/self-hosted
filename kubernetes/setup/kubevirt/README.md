# KubeVirt

## Setup

See `./setup.sh`

## Quickstart

```bash
# create image template
kubectl apply -f https://kubevirt.io/labs/manifests/vm.yaml
kubectl get vms

# start vm
virtctl start testvm  # it would show up as `pod`
kubectl get vmis  # running instances

# access vm
virtctl console testvm
virtctl vnc testvm # for graphical access

# teardown
virtctl stop testvm
kubectl delete vm testvm
```

## Monitoring

<https://github.com/kubevirt/monitoring>

## Refs
- <https://kubevirt.io/quickstart_cloud/>
- <https://kubevirt.io/labs/kubernetes/lab1>
