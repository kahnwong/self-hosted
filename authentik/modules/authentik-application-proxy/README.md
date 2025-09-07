# Authentik Application Proxy

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| authentik | 2025.8.0 |
| random | 3.7.2 |

## Providers

| Name | Version |
|------|---------|
| authentik | 2024.8.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [authentik_application.this](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/resources/application) | resource |
| [authentik_provider_proxy.this](https://registry.terraform.io/providers/goauthentik/authentik/2025.8.0/docs/resources/provider_proxy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_name | n/a | `string` | n/a | yes |
| authorization\_flow\_id | n/a | `string` | n/a | yes |
| invalidation\_flow\_id | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| provider\_proxy\_id | n/a |
<!-- END_TF_DOCS -->
