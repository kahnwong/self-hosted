# tf-github

## Tangled Mirror Secrets

```bash
base64 -w 0 ~/.ssh/tangled-github-ci | xargs echo -n | gh secret set TANGLED_SSH_KEY --repo kahnwong/nix
base64 -w 0 ~/.ssh/tangled-github-ci | xargs echo -n | gh secret set TANGLED_SSH_KEY --repo kahnwong/self-hosted
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.2.7 |
| github | 6.12.1 |
| sops | 1.4.1 |

## Providers

| Name | Version |
| ---- | ------- |
| github | 6.12.1 |
| sops | 1.4.1 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [github_actions_secret.cloudflare_pages](https://registry.terraform.io/providers/integrations/github/6.12.1/docs/resources/actions_secret) | resource |
| [github_actions_secret.docs_algolia](https://registry.terraform.io/providers/integrations/github/6.12.1/docs/resources/actions_secret) | resource |
| [github_actions_secret.vercel](https://registry.terraform.io/providers/integrations/github/6.12.1/docs/resources/actions_secret) | resource |
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/1.4.1/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| github\_token | need for github auth | `string` | n/a | yes |
| private\_cloudflare\_pages\_repos | n/a | `set(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
