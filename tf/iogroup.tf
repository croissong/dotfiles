provider "outlook" {}


resource "outlook_mail_folder" "service" {
  name = "service"
}
