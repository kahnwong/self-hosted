variable "host" {
  type = string
}

variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = "nuc"
}

variable "ghcr_username" {
  type = string
}
variable "ghcr_token" {
  type = string
}
