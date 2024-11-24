vm_details = {
  agent_number        = 1
  socket_number       = 1
  cpu_type            = "x86-64-v2-AES"
  scsihw              = "virtio-scsi-pci"
  qemu_os             = "l26"
  target_node         = "pve"
  onboot              = true
  iso_name            = "local:iso/talos-factory-image-181.iso"
  storage             = "local-lvm"
  ipconfig            = "ip=dhcp"
  nameserver          = "x.x.x.x"
}

talos_cluster_details = {
  name         = "talos-cl01"
  version      = "v1.8.1"
  schematic_id = "SCHEMATIC ID Definitions"
}

controller = {
  controller01 = { hdd_capacity = "10G", name = "controller01", vmid = 505, vmodel = "virtio", vnetwork = "vmbr3", vcores = 2, vram = 2048 }
  controller02 = { hdd_capacity = "10G", name = "controller02", vmid = 506, vmodel = "virtio", vnetwork = "vmbr3", vcores = 2, vram = 2048 }
}

worker = {
  worker01 = { hdd_capacity = "15G", name = "worker01", vmid = 507, vmodel = "virtio", vnetwork = "vmbr3", vcores = 4, vram = 4096 }
  worker02 = { hdd_capacity = "15G", name = "worker02", vmid = 508, vmodel = "virtio", vnetwork = "vmbr3", vcores = 4, vram = 4096 }
}