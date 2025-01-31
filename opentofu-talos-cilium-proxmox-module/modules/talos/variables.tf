variable "api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "api_token_id" {
  description = "Proxmox API Toke ID"
  type        = string
}

variable "api_token_secret" {
  description = "Proxmox API Toke Secret"
  type        = string
}

variable "vm_details" {
  description = "VM Generic Settings"
  type = object({
    target_node         = string
    agent_number        = optional(number)
    socket_number       = optional(number)
    talos_template_name = optional(string)
    cpu_type            = optional(string)
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
  description = "Talos Cluster Details"
  type = object({
    name               = string
    version            = string
    schematic_id       = string
    cilium_cli_version = string
    cilium_version     = string
  })
}

variable "node" {
  description = "Configuration Talos Cluster Nodes"
  type = map(object({
    vmodel       = string
    hdd_capacity = string
    vmid         = number
    vnetwork     = string
    vcores       = number
    vram         = number
  }))
}