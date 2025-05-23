# Authentik

## Applications

- [gitea](https://docs.goauthentik.io/integrations/services/gitea/)
- [harbor](https://goharbor.io/docs/2.11.0/administration/configure-authentication/oidc-auth/)
  - OIDC endpoint should be something like this: `https://authentik.xxx.xxx/application/o/harbor/`
  - Needs `offline_access`: <https://github.com/goauthentik/authentik/issues/9836>
- [immich](https://immich.app/docs/administration/oauth/)
- [linkding](https://github.com/sissbruecker/linkding/issues/486#issuecomment-1621104061)
- [memos](https://www.usememos.com/docs/advanced-settings/authentik)
- [miniflux](https://miniflux.app/docs/howto.html)
- [minio](https://docs.goauthentik.io/integrations/services/minio/)
- [opengist](https://opengist.io/docs/configuration/oauth-providers.html)
- [proxmox](https://docs.goauthentik.io/integrations/services/proxmox-ve/)

## Useful values

```txt
OpenID Configuration Issuer:  https://authentik.karnwong.me/application/o/$APP/
```

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
| [authentik_stage_identification.default-authentication-identification](https://registry.terraform.io/providers/goauthentik/authentik/2024.8.4/docs/resources/stage_identification) | resource |
| [authentik_flow.default-authorization-flow](https://registry.terraform.io/providers/goauthentik/authentik/2024.8.4/docs/data-sources/flow) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authentik\_host | n/a | `string` | n/a | yes |
| authentik\_token | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| oauth2\_credentials | n/a |
<!-- END_TF_DOCS -->
