# Define the Initial Image link copied from the Talos Factory guide from an earlier stage
locals {
  initial_image = "factory.talos.dev/installer/${var.talos_cluster_details.schematic_id}:${var.talos_cluster_details.version}"
}

# Generate the Talos client configuration
data "talos_client_configuration" "talosconfig" {
  cluster_name         = var.talos_cluster_details.name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for v in proxmox_vm_qemu.talos_nodes : v.default_ipv4_address if can(regex("controller", lower(v.name)))]
  nodes                = [for v in proxmox_vm_qemu.talos_nodes : v.default_ipv4_address if can(regex("controller", lower(v.name)))]
}

# Generate the Talos nodes configuration and instantiate the Initial Talos Image
data "talos_machine_configuration" "machineconfig" {
  for_each         = { for i, v in proxmox_vm_qemu.talos_nodes : i => v }
  cluster_name     = var.talos_cluster_details.name
  talos_version    = var.talos_cluster_details.version
  cluster_endpoint = "https://${tolist([for v in proxmox_vm_qemu.talos_nodes : v.default_ipv4_address if can(regex("controller", lower(v.name)))])[0]}:6443"
  # Define the Talos machine_type based on the node name. If controller then controlplane if worker then worker
  machine_type = can(regex("controller", lower(each.value.name))) ? "controlplane" : (
    can(regex("worker", lower(each.value.name))) ? "worker" : "unknown"
  )
  machine_secrets = talos_machine_secrets.this.machine_secrets

  config_patches = can(regex("controller", lower(each.value.name))) ? [
    templatefile("${path.module}/files/init_install_controller.tfmpl", {
      initial_image = local.initial_image
    }),
    templatefile("${path.module}/files/cilium_config.tfmpl", {
      cilium_cli_version = var.talos_cluster_details.cilium_cli_version
      cilium_version     = var.talos_cluster_details.cilium_version
    })
    ] : [
    templatefile("${path.module}/files/init_install_worker.tfmpl", {
      initial_image = local.initial_image
    })
  ]
}

# Check whether the Talos cluster is in a healthy state
data "talos_cluster_health" "cluster_health" {
  client_configuration = data.talos_client_configuration.talosconfig.client_configuration
  control_plane_nodes  = [for v in proxmox_vm_qemu.talos_nodes : v.default_ipv4_address if can(regex("controller", lower(v.name)))]
  worker_nodes         = [for v in proxmox_vm_qemu.talos_nodes : v.default_ipv4_address if can(regex("worker", lower(v.name)))]
  endpoints            = data.talos_client_configuration.talosconfig.endpoints
  # Include the Health Check timeout condition and remove the sleep condition in the main.tf file
  timeouts = {
    read = "10m"
  }
}