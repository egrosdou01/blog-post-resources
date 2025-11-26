variable "api_url" {
  description = "The Proxmox API URL"
  type        = string
}

variable "api_token_id" {
  description = "The Proxmox API Toke ID"
  type        = string
}

variable "api_token_secret" {
  description = "The Proxmox API Toke Secret"
  type        = string
}

variable "vm_details" {
  description = "VM generic settings"
  type = object({
    target_node         = string
    agent_number        = optional(number)
    socket_number       = optional(number)
    skip_ipv6           = optional(bool, true)
    talos_template_name = optional(string)
    type                = optional(string)
    scsihw              = optional(string)
    qemu_os             = optional(string)
    onboot              = optional(bool, true)
    iso_name            = optional(string)
    storage             = optional(string)
    ipconfig            = optional(string)
    nameserver          = optional(string)
  })
}

variable "talos_cluster_details" {
  description = "The Talos cluster details"
  type = object({
    version            = string
    schematic_id       = string
    cilium_cli_version = string
    cilium_version     = string
  })
}

variable "clusters" {
  description = "Specification of the different Talos clusters and nodes"
  type = map(object({
    nodes = map(object({
      id           = number
      vmodel       = string
      hdd_capacity = string
      vmid         = number
      vnetwork     = string
      vcores       = number
      vram         = number
    }))
  }))
}