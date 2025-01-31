module "talos-cluster" {
  source = "./modules/talos"

  api_url          = var.api_url
  api_token_id     = var.api_token_id
  api_token_secret = var.api_token_secret

  vm_details = {
    agent_number  = 1
    socket_number = 1
    cpu_type      = "x86-64-v2-AES"
    scsihw        = "virtio-scsi-pci"
    qemu_os       = "l26"
    # Ensure the target_node name is defined correctly based on your system settings
    target_node = "pve"
    onboot      = true
    # Ensure the .iso filename is defined correctly based on your system settings
    iso_name = "local:iso/talos-factory-image.iso"
    # Ensure the storage name is defined correctly based on your system settings
    storage  = "local-lvm"
    ipconfig = "ip=dhcp"
    # Define the DNS IP Address based on your system settings
    nameserver = "x.x.x.x"
  }

  talos_cluster_details = {
    name               = "talos-cl01"
    version            = "v1.8.1"
    schematic_id       = "SCHEMATIC ID Definition"
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
      vmid         = 508
      vnetwork     = "vmbr3"
      vcores       = 2
      vram         = 2048
    }
    worker02 = {
      vmodel       = "virtio"
      hdd_capacity = "10G"
      vmid         = 509
      vnetwork     = "vmbr3"
      vcores       = 2
      vram         = 2048
    }
    worker03 = {
      vmodel       = "virtio"
      hdd_capacity = "10G"
      vmid         = 510
      vnetwork     = "vmbr3"
      vcores       = 2
      vram         = 2048
    }
  }
}