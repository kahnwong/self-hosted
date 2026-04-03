variable "authorization_flow_id" {
  type = string
}
variable "invalidation_flow_id" {
  type = string
}

variable "application_name" {
  type = string
}

variable "redirect_uris" {
  type = list(string)
}

variable "property_mappings" { # Oauth mapping: email, offline_access, openid, profile
  type = list(string)
}

variable "signing_key" { # System > Certificates
  type = string
}
