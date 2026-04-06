variable "cluster_name" {
  type = string
}

variable "secrets" {
  type = map(list(string))
}

variable "ghcr_namespaces" {
  type = set(string)
}

variable "ghcr_username" {
  type = string
}
variable "ghcr_token" {
  type = string
}
