terraform {
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
