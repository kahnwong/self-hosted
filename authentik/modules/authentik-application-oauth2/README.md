# Authentik Application Oauth2

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| authentik | 2024.8.4 |
| random | 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| authentik | 2024.8.4 |
| random | 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [authentik_application.memos](https://registry.terraform.io/providers/goauthentik/authentik/2024.8.4/docs/resources/application) | resource |
| [authentik_provider_oauth2.this](https://registry.terraform.io/providers/goauthentik/authentik/2024.8.4/docs/resources/provider_oauth2) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_name | n/a | `string` | n/a | yes |
| authentik\_flow\_id | n/a | `string` | n/a | yes |
| redirect\_uris | n/a | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| oauth\_client\_id | n/a |
| oauth\_client\_secret | n/a |
| provider\_oauth2\_id | n/a |
<!-- END_TF_DOCS -->
