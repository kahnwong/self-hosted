# Authentik (r440)



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| authentik | 2025.12.1 |

## Providers

| Name | Version |
|------|---------|
| authentik | 2025.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| application\_oauth2 | ./modules/authentik-application-oauth2 | n/a |
| application\_proxy | ./modules/authentik-application-proxy | n/a |

## Resources

| Name | Type |
|------|------|
| [authentik_flow.passwordless_authentication](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/flow) | resource |
| [authentik_flow_stage_binding.passwordless_login](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.passwordless_webauthn_validation](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/flow_stage_binding) | resource |
| [authentik_outpost.proxy_outpost](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/outpost) | resource |
| [authentik_policy_binding.app_access](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/policy_binding) | resource |
| [authentik_service_connection_kubernetes.local](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/service_connection_kubernetes) | resource |
| [authentik_stage_authenticator_validate.webauthn_validation](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/stage_authenticator_validate) | resource |
| [authentik_stage_identification.default_authentication_identification](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/stage_identification) | resource |
| [authentik_stage_user_login.default_authentication_login](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/resources/stage_user_login) | resource |
| [authentik_flow.default-authorization-flow](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/data-sources/flow) | data source |
| [authentik_flow.default-invalidation-flow](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/data-sources/flow) | data source |
| [authentik_group.admins](https://registry.terraform.io/providers/goauthentik/authentik/2025.12.1/docs/data-sources/group) | data source |

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
