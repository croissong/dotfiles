module "mail" {
  source = "../priv/tf/mail"
}


data "azuread_client_config" "current" {}

resource "azuread_application" "mail_auth" {
  display_name     = "mail-auth"
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMultipleOrgs"
}

resource "azuread_application_password" "mail_auth" {
  application_object_id = azuread_application.mail_auth.object_id
}

# resource "azuread_service_principal" "mail_auth" {
#   application_id               = azuread_application.mail_auth.application_id
#   app_role_assignment_required = false
#   owners                       = [data.azuread_client_config.current.object_id]
# }


resource "sops_file" "secrets" {
  encryption_type = "age"
  content = yamlencode({
    mail_auth = {
      client_id     = azuread_application.mail_auth.application_id
      client_secret = azuread_application_password.mail_auth.value
    }
  })
  filename = "secrets-output.yml"
  age = {
    key = "age1d2mr4ka46pms3j042gyshm3jjxth9jq4cje63nvfkzaz5g8e2q6qxrg588"
  }
}
