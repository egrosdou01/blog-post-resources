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
    agent_number        = number
    socket_number       = number
    talos_template_name = optional(string)
    cpu_type            = string
    scsihw              = string
    qemu_os             = string
    target_node         = string
    onboot              = bool
    iso_name            = string
    storage             = string
    ipconfig            = string
    nameserver          = string
  })
}

variable "talos_cluster_details" {
  description = "The Talos cluster details"
  type = object({
    name         = string
    version      = string
    schematic_id = string
  })
}

variable "controller" {
  description = "Create your controller nodes"
  type = object({
    controller01 = map(any)
    controller02 = map(any)
  })
}

variable "worker" {
  description = "Create your worker nodes"
  type = object({
    worker01 = map(any)
    worker02 = map(any)
  })
}
