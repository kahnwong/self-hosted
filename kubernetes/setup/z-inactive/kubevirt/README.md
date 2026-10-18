# KubeVirt

## Fix no internet on reboot

`sudo vi /etc/netplan/50-cloud-init.yaml`

```yaml
network:
  version: 2
  ethernets:
    enp1s0:
      match:
        # macaddress: "xx:xx:xx:xx:xx:xx"
        name: e*  # add this line
      dhcp4: true
      dhcp6: true
      set-name: "enp1s0"
```
