# Local variable to merge the maps into a map
locals {
  all_clusters = merge([
    for cluster_name, cluster_config in var.clusters : {
      for node_name, node_details in cluster_config.nodes :
      "${cluster_name}-${node_name}" => merge(node_details, {
        cluster_name = cluster_name
        node_name    = node_name
        full_name    = "${cluster_name}-${node_name}"
      })
    }
  ]...)
}

# Random ID to be appended to the cluster creation
resource "random_id" "cluster_random_name" {
  byte_length = 3
}

# Create the controller and worker nodes 
resource "proxmox_vm_qemu" "talos_nodes" {
  for_each = local.all_clusters

  name          = "${each.value.full_name}-${random_id.cluster_random_name.hex}"
  target_node   = var.vm_details.target_node
  vmid          = each.value.vmid
  agent         = var.vm_details.agent_number
  skip_ipv6     = var.vm_details.skip_ipv6
  agent_timeout = 60
  memory        = each.value.vram
  scsihw        = var.vm_details.scsihw
  qemu_os       = var.vm_details.qemu_os
  onboot        = var.vm_details.onboot

  cpu {
    cores   = each.value.vcores
    type    = var.vm_details.type
    sockets = var.vm_details.socket_number
  }

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
    id     = each.value.id
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
