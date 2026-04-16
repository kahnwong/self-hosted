# llm-d


## Test setup

```bash
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable traefik" sh # so it frees up port 80 and 443
sudo k3s kubectl config view --raw > ~/.kube/config
```




## Refs

- <https://llm-d.ai/docs/guide>
- <https://llm-d.ai/docs/guide/Installation/inference-scheduling>
