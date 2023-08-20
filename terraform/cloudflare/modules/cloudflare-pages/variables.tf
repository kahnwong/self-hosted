variable "account_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "production_branch" {
  type    = string
  default = "master"
}

variable "subdomain" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}
