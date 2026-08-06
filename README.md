# self-hosted

I have a self-hosting problem, in case you couldn't tell.

## Set inotify limit

```bash
sudo sysctl -w fs.inotify.max_user_watches=1024288
```

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
