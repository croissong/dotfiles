terraform {
  cloud {
    organization = "dotfiles"

    workspaces {
      name = "dotfiles"
    }
  }
}
