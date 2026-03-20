# ref: <https://blog.joshuastock.net/authentik-passwordless-authentication-integrating-social-login-and-yubikey>
resource "authentik_flow" "passwordless_authentication" {
  name        = "Passwordless Authentication"
  title       = "Passwordless authentication"
  slug        = "passwordless-authentication"
  designation = "authentication"

  policy_engine_mode = "any"
  compatibility_mode = true
  denied_action      = "message_continue"
  layout             = "stacked"

  authentication = "none"
}

resource "authentik_stage_authenticator_validate" "webauthn_validation" {
  name                       = "WebAuthn Validation Stage"
  not_configured_action      = "deny"
  device_classes             = ["webauthn"]
  last_auth_threshold        = "seconds=0"
  webauthn_user_verification = "required"
}
resource "authentik_flow_stage_binding" "passwordless_webauthn_validation" {
  target                  = authentik_flow.passwordless_authentication.uuid
  stage                   = authentik_stage_authenticator_validate.webauthn_validation.id
  order                   = 0
  re_evaluate_policies    = true
  policy_engine_mode      = "any"
  invalid_response_action = "retry"
}

# import {
#   id = "xxxx"
#   to = authentik_stage_user_login.default_authentication_login
# }
resource "authentik_stage_user_login" "default_authentication_login" {
  name               = "default-authentication-login"
  session_duration   = "hours=12"
  remember_me_offset = "seconds=0"
  geoip_binding      = "bind_continent_country_city"
  network_binding    = "bind_asn"
}
resource "authentik_flow_stage_binding" "passwordless_login" {
  target = authentik_flow.passwordless_authentication.uuid
  stage  = authentik_stage_user_login.default_authentication_login.id
  order  = 10

  re_evaluate_policies    = true
  policy_engine_mode      = "any"
  invalid_response_action = "retry"
}

# import {
#   id = "xxxx"
#   to = authentik_stage_identification.default-authentication-identification
# }
resource "authentik_stage_identification" "default_authentication_identification" {
  name                      = "default-authentication-identification"
  case_insensitive_matching = true
  user_fields = [
    "email",
    "username",
  ]
  passwordless_flow = authentik_flow.passwordless_authentication.uuid
}
