vm_details = {
  agent_number  = 1
  socket_number = 1
  skip_ipv6     = true
  type          = "x86-64-v2-AES"
  scsihw        = "virtio-scsi-pci"
  qemu_os       = "l26"
  target_node   = "pve"
  onboot        = true
  iso_name      = "local:iso/talos-factory-image.iso"
  storage       = "local-lvm"
  ipconfig      = "ip=dhcp"
  nameserver    = "10.10.10.1"
}

talos_cluster_details = {
  version            = "v1.11.3"
  schematic_id       = "ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d6123456"
  cilium_cli_version = "v0.18.0"
  cilium_version     = "v1.18.0"
}

clusters = {
  "cluster1" = {
    nodes = {
      "controller01" = {
        id           = 0
        vmodel       = "virtio"
        hdd_capacity = "10G"
        vmid         = 105
        vnetwork     = "vmbr3"
        vcores       = 2
        vram         = 2048
      },
      "worker01" = {
        id           = 0
        vmodel       = "virtio"
        hdd_capacity = "10G"
        vmid         = 106
        vnetwork     = "vmbr3"
        vcores       = 2
        vram         = 2048
      }
    }
  },
  "cluster2" = {
    nodes = {
      "controller01" = {
        id           = 0
        vmodel       = "virtio"
        hdd_capacity = "10G"
        vmid         = 107
        vnetwork     = "vmbr3"
        vcores       = 2
        vram         = 2048
      },
      "worker01" = {
        id           = 0
        vmodel       = "virtio"
        hdd_capacity = "10G"
        vmid         = 108
        vnetwork     = "vmbr3"
        vcores       = 2
        vram         = 2048
      }
    }
  }
}
