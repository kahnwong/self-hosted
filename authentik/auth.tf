# can't get it to work :(
# # ----- passkey binding -----
# # data "authentik_webauthn_device_type" "bitwarden" {
# #   description = "YubiKey 5 Series with NFC"
# # }
# resource "authentik_stage_authenticator_webauthn" "passkey" {
#   name = "passkey-setup"
#   # device_type_restrictions = [
#   #   data.authentik_webauthn_device_type.bitwarden.aaguid,
#   # ]
#
#   user_verification = "required"
# }
#
# resource "authentik_flow" "passkey" {
#   name        = "passwordless-flow"
#   title       = "passwordless flow"
#   slug        = "passwordless-flow"
#   designation = "authentication"
# }
#
# resource "authentik_flow_stage_binding" "passkey" {
#   target = authentik_flow.passkey.uuid
#   stage  = authentik_stage_authenticator_webauthn.passkey.id
#   order  = 10
# }
#

# # ----- login binding -----
# data "authentik_stage" "default-authentication-login" {
#   name = "default-authentication-login"
# }
# resource "authentik_flow_stage_binding" "passkey_login" {
#   target = authentik_flow.passkey.uuid
#   stage  = data.authentik_stage.default-authentication-login.id
#   order  = 20
# }

# ----- identification -----
## obtain from browser inspector
# import {
#   id = "xxxx"
#   to = authentik_stage_identification.default-authentication-identification
# }
resource "authentik_stage_identification" "default-authentication-identification" {
  name                      = "default-authentication-identification"
  case_insensitive_matching = true
  user_fields = [
    "email",
    "username",
  ]
  # passwordless_flow = authentik_flow.passkey.uuid
}
