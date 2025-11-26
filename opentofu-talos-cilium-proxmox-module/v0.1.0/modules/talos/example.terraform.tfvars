vm_details = {
  agent_number  = 1
  socket_number = 1
  cpu_type      = "x86-64-v2-AES"
  scsihw        = "virtio-scsi-pci"
  qemu_os       = "l26"
  target_node   = "pve"
  onboot        = true
  iso_name      = "local:iso/talos-factory-image.iso"
  storage       = "local-lvm"
  ipconfig      = "ip=dhcp"
  nameserver    = "x.x.x.x"
}

talos_cluster_details = {
  name               = "talos-cl01"
  version            = "v1.8.1"
  schematic_id       = "SCHEMATIC ID Definitions"
  cilium_cli_version = "v0.16.20"
  cilium_version     = "v1.16.4"
}

node = {
  controller01 = {
    vmodel       = "virtio"
    hdd_capacity = "10G"
    vmid         = 505
    vnetwork     = "vmbr3"
    vcores       = 2
    vram         = 2048
  }
  controller02 = {
    vmodel       = "virtio"
    hdd_capacity = "10G"
    vmid         = 506
    vnetwork     = "vmbr3"
    vcores       = 2
    vram         = 2048
  }
  worker01 = {
    vmodel       = "virtio"
    hdd_capacity = "10G"
    vmid         = 507
    vnetwork     = "vmbr3"
    vcores       = 2
    vram         = 2048
  }
  worker02 = {
    vmodel       = "virtio"
    hdd_capacity = "10G"
    vmid         = 508
    vnetwork     = "vmbr3"
    vcores       = 2
    vram         = 2048
  }
}
