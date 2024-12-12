terraform {
  required_version = "~> 1.8.1"

  required_providers {
    random = {
      source  = "opentofu/random"
      version = "3.6.2"
    }
    proxmox = {
      source  = "registry.opentofu.org/telmate/proxmox"
      version = "3.0.1-rc4"
    }
    talos = {
      source  = "registry.opentofu.org/siderolabs/talos"
      version = "0.6.1"
    }
  }
}

provider "proxmox" {
  pm_api_url          = file(var.api_url)
  pm_api_token_id     = file(var.api_token_id)
  pm_api_token_secret = file(var.api_token_secret)
  pm_tls_insecure     = true
}
