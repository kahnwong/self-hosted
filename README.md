# self-hosted

I have a self-hosting problem, in case you couldn't tell.

## Set inotify limit

```bash
sudo sysctl -w fs.inotify.max_user_watches=1024288
```

## Set k3s to use in-memory storage for logs

Add these to `fstab`:

```bash
# /etc/fstab

tmpfs    /var/log/pods        tmpfs    nodev,nosuid,noexec,mode=0755,size=100M    0    0
tmpfs    /var/log/containers  tmpfs    nodev,nosuid,noexec,mode=0755,size=50M     0    0
```

For migrating to in-memory storage:

```bash
sudo systemctl stop k3s
sudo rm -rf /var/log/pods/* /var/log/containers/*

sudo mount -a # check via `df -h -t tmpfs`
sudo systemctl restart k3s
```

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
