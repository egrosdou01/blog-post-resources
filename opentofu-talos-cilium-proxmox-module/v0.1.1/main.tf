module "talos-cluster" {
  source = "./modules/talos"

  api_url          = var.api_url
  api_token_id     = var.api_token_id
  api_token_secret = var.api_token_secret

  vm_details = {
    agent_number  = 1
    socket_number = 1
    skip_ipv6     = true
    type          = "x86-64-v2-AES"
    scsihw        = "virtio-scsi-pci"
    qemu_os       = "l26"
    # Ensure the target_node name is defined correctly
    target_node = "pve"
    onboot      = true
    # Ensure the .iso filename is defined correctly based on your system settings
    iso_name = "local:iso/your-iso-name"
    # Ensure the storage name is defined correctly based on your system settings
    storage  = "local-lvm"
    ipconfig = "ip=dhcp"
    # Define the DNS IP Address based on your system settings
    nameserver = "x.x.x.x"
  }

  talos_cluster_details = {
    version            = "v1.11.3"
    schematic_id       = "SCHEMATIC ID Definition"
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
}