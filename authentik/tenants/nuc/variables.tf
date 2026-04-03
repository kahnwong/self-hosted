variable "authentik_host" {
  type = string
}

variable "authentik_token" {
  type = string
}

variable "property_mappings" {
  type = list(string)
}

variable "signing_key" {
  type = string
}
