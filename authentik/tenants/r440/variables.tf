variable "authentik_host" {
  type = string
}

variable "authentik_token" {
  type = string
}

variable "property_mappings" {
  type = list(string)
  default = [
    "777fa2fb-e6e8-4790-8c6b-52e23d9514bf",
    "737fdadc-bc80-4dcc-9259-c94bdbe76101",
    "68004046-feac-4819-90b1-7ab0cee66dbf",
    "1f6f9ee0-9d07-48df-b85c-eafe6119c530",
  ]
}

variable "signing_key" {
  type    = string
  default = "e8fd0a24-879c-4cca-8823-5afd04f75af2"
}
