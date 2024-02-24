module "mail" {
  source = "../../priv/tf/mail"
}


data "azuread_client_config" "current" {}

resource "azuread_application" "mail_auth" {
  display_name     = "mail-auth"
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMultipleOrgs"

  web {
    redirect_uris = ["http://localhost:8080/"]
  }
}

resource "azuread_application_password" "mail_auth" {
  application_id = azuread_application.mail_auth.id
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
      client_id     = azuread_application.mail_auth.client_id
      client_secret = azuread_application_password.mail_auth.value
    }
    backup_bucket = {
      bucket_name = b2_bucket.backup.bucket_name
      key_id      = b2_application_key.autorestic_key.application_key_id
      key         = b2_application_key.autorestic_key.application_key
    }
  })
  filename = "secrets-output.yml"
  age = {
    key = "age1d2mr4ka46pms3j042gyshm3jjxth9jq4cje63nvfkzaz5g8e2q6qxrg588"
  }
}


import {
  to = module.mail.outlook_message_rule.noop_to
  id = "AgAABmYfvGU="
}

import {
  to = module.mail.outlook_message_rule.ops_from
  id = "AgAABmYfvGQ="
}

import {
  to = module.mail.outlook_message_rule.ops_to
  id = "AgAABmYfvGc="
}

import {
  to = module.mail.outlook_message_rule.junk_from
  id = "AgAABmYfvGM="
}

import {
  to = module.mail.outlook_message_rule.delete_subjects
  id = "AgAABmYfvGE="
}

import {
  to = module.mail.outlook_message_rule.delete_to
  id = "AgAABmYfvGI="
}

import {
  to = module.mail.outlook_message_rule.delete_from
  id = "AgAABmYfvGY="
}
