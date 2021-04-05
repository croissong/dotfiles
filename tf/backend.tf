terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "dotfiles"

    workspaces {
      name = "dotfiles"
    }
  }
}
