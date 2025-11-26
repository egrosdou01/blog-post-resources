terraform {
  required_providers {
    random = {
      source  = "opentofu/random"
      version = "3.6.2"
    }
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc04"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.8.1"
    }
  }
}
