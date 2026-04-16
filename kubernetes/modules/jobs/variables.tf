variable "jobs" {
  type = map(list(string))
}

variable "chart_name" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "values_extras" {
  type = list(string)
}
