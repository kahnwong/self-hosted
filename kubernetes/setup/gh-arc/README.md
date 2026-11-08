# Github Actions Runner Controller

Use `GitHub App` for auth method.

```bash
# install arc controller
NAMESPACE="arc-systems"
helm install arc \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

# install runner
./install.sh $REPO
```

## References

- [Get started with Actions Runner Controller](https://docs.github.com/en/actions/tutorials/use-actions-runner-controller/get-started)
- [Authenticating ARC to the GitHub API](https://docs.github.com/en/actions/how-tos/manage-runners/use-actions-runner-controller/authenticate-to-the-api)
