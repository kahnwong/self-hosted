# Authentik

## Applications

- [harbor](https://goharbor.io/docs/2.11.0/administration/configure-authentication/oidc-auth/)
  - OIDC endpoint should be something like this: `https://authentik.xxx.xxx/application/o/harbor/`
  - Needs `offline_access`: <https://github.com/goauthentik/authentik/issues/9836>
- [memos](https://www.usememos.com/docs/advanced-settings/authentik)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| authentik | 2024.8.4 |

## Providers

| Name | Version |
|------|---------|
| authentik | 2024.8.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| application\_oauth2 | ./modules/authentik-application-oauth2 | n/a |
| application\_proxy | ./modules/authentik-application-proxy | n/a |

## Resources

| Name | Type |
|------|------|
| [authentik_outpost.proxy_outpost](https://registry.terraform.io/providers/goauthentik/authentik/2024.8.4/docs/resources/outpost) | resource |
| [authentik_service_connection_kubernetes.local](https://registry.terraform.io/providers/goauthentik/authentik/2024.8.4/docs/resources/service_connection_kubernetes) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authentik\_host | n/a | `string` | n/a | yes |
| authentik\_token | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->
