# Authentik

## Applications

- [gitea](https://docs.goauthentik.io/integrations/services/gitea/)
- [harbor](https://goharbor.io/docs/2.11.0/administration/configure-authentication/oidc-auth/)
  - OIDC endpoint should be something like this: `https://authentik.xxx.xxx/application/o/harbor/`
  - Needs `offline_access`: <https://github.com/goauthentik/authentik/issues/9836>
  - oidc scope: `openid,profile,email,offline_access`
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
| authentik | 2025.8.1 |

## Providers

| Name | Version |
|------|---------|
| authentik | 2025.8.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| application\_oauth2 | ./modules/authentik-application-oauth2 | n/a |
| application\_proxy | ./modules/authentik-application-proxy | n/a |

## Resources

| Name | Type |
|------|------|
| [authentik_flow.passwordless_authentication](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/resources/flow) | resource |
| [authentik_flow_stage_binding.passwordless_login](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.passwordless_webauthn_validation](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/resources/flow_stage_binding) | resource |
| [authentik_outpost.proxy_outpost](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/resources/outpost) | resource |
| [authentik_service_connection_kubernetes.local](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/resources/service_connection_kubernetes) | resource |
| [authentik_stage_authenticator_validate.webauthn_validation](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/resources/stage_authenticator_validate) | resource |
| [authentik_stage_identification.default_authentication_identification](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/resources/stage_identification) | resource |
| [authentik_stage_user_login.default_authentication_login](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/resources/stage_user_login) | resource |
| [authentik_flow.default-authorization-flow](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/data-sources/flow) | data source |
| [authentik_flow.default-invalidation-flow](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.1/docs/data-sources/flow) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authentik\_host | n/a | `string` | n/a | yes |
| authentik\_token | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| oauth2\_credentials | n/a |
<!-- END_TF_DOCS -->etes.local](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/resources/service_connection_kubernetes) | resource |
| [authentik_stage_identification.default-authentication-identification](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/resources/stage_identification) | resource |
| [authentik_flow.default-authorization-flow](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-invalidation-flow](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/data-sources/flow) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authentik\_host | n/a | `string` | n/a | yes |
| authentik\_token | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| oauth2\_credentials | n/a |
<!-- END_TF_DOCS -->etes.local](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/resources/service_connection_kubernetes) | resource |
| [authentik_stage_identification.default-authentication-identification](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/resources/stage_identification) | resource |
| [authentik_flow.default-authorization-flow](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-invalidation-flow](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/data-sources/flow) | data source |

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
