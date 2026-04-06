variable "cluster_name" {
  type = string
}

variable "configmaps" {
  type = map(list(object({
    source     = string
    filename   = string
    input_type = optional(string)
  })))
}
