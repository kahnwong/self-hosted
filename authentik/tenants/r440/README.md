# Authentik (r440)



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| authentik | 2026.2.0 |

## Providers

| Name | Version |
|------|---------|
| authentik | 2026.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| application\_oauth2 | ../../modules/authentik-application-oauth2 | n/a |
| application\_proxy | ../../modules/authentik-application-proxy | n/a |

## Resources

| Name | Type |
|------|------|
| [authentik_flow.passwordless_authentication](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/flow) | resource |
| [authentik_flow_stage_binding.passwordless_login](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/flow_stage_binding) | resource |
| [authentik_flow_stage_binding.passwordless_webauthn_validation](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/flow_stage_binding) | resource |
| [authentik_outpost.proxy_outpost](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/outpost) | resource |
| [authentik_policy_binding.app_access](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/policy_binding) | resource |
| [authentik_service_connection_kubernetes.local](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/service_connection_kubernetes) | resource |
| [authentik_stage_authenticator_validate.webauthn_validation](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/stage_authenticator_validate) | resource |
| [authentik_stage_identification.default_authentication_identification](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/stage_identification) | resource |
| [authentik_stage_user_login.default_authentication_login](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/resources/stage_user_login) | resource |
| [authentik_flow.default-authorization-flow](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/data-sources/flow) | data source |
| [authentik_flow.default-invalidation-flow](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/data-sources/flow) | data source |
| [authentik_group.admins](https://registry.terraform.io/providers/goauthentik/authentik/2026.2.0/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authentik\_host | n/a | `string` | n/a | yes |
| authentik\_token | n/a | `string` | n/a | yes |
| property\_mappings | n/a | `list(string)` | ```[ "777fa2fb-e6e8-4790-8c6b-52e23d9514bf", "737fdadc-bc80-4dcc-9259-c94bdbe76101", "68004046-feac-4819-90b1-7ab0cee66dbf", "1f6f9ee0-9d07-48df-b85c-eafe6119c530" ]``` | no |
| signing\_key | n/a | `string` | `"e8fd0a24-879c-4cca-8823-5afd04f75af2"` | no |

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
