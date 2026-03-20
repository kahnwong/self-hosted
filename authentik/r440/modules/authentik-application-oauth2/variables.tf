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
