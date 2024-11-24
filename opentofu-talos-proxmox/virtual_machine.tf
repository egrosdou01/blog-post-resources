# Random ID to be appended to the node creation
resource "random_id" "cluster_random_name" {
  byte_length = 3
}

# Create the controller and worker Nodes 
resource "proxmox_vm_qemu" "talos_vm_controller" {
  for_each = var.controller

  name        = "${each.value.name}-${random_id.cluster_random_name.hex}"
  target_node = var.vm_details.target_node
  vmid        = each.value.vmid

  # Basic VM settings here. agent refers to guest agent
  agent         = var.vm_details.agent_number
  agent_timeout = 60
  cores         = each.value.vcores
  sockets       = var.vm_details.socket_number
  cpu           = var.vm_details.cpu_type
  memory        = each.value.vram
  scsihw        = var.vm_details.scsihw
  qemu_os       = var.vm_details.qemu_os
  onboot        = var.vm_details.onboot

  disks {
    ide {
      ide0 {
        cdrom {
          iso = var.vm_details.iso_name
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = each.value.hdd_capacity
          storage = var.vm_details.storage
        }
      }
    }
  }

  network {
    model  = each.value.vmodel
    bridge = each.value.vnetwork
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      network, disk, target_node
    ]
  }

  ipconfig0  = var.vm_details.ipconfig
  nameserver = var.vm_details.nameserver
}

# Create the controller and worker Nodes 
resource "proxmox_vm_qemu" "talos_vm_worker" {
  for_each = var.worker

  name        = "${each.value.name}-${random_id.cluster_random_name.hex}"
  target_node = var.vm_details.target_node
  vmid        = each.value.vmid

  # Basic VM settings here. agent refers to guest agent
  agent         = var.vm_details.agent_number
  agent_timeout = 60
  cores         = each.value.vcores
  sockets       = var.vm_details.socket_number
  cpu           = var.vm_details.cpu_type
  memory        = each.value.vram
  scsihw        = var.vm_details.scsihw
  qemu_os       = var.vm_details.qemu_os
  onboot        = var.vm_details.onboot

  disks {
    ide {
      ide0 {
        cdrom {
          iso = var.vm_details.iso_name
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = each.value.hdd_capacity
          storage = var.vm_details.storage
        }
      }
    }
  }

  network {
    model  = each.value.vmodel
    bridge = each.value.vnetwork
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      network, disk, target_node
    ]
  }

  ipconfig0  = var.vm_details.ipconfig
  nameserver = var.vm_details.nameserver
}