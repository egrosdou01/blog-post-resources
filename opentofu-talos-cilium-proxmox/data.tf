# Define the Initial Image link copied from the Talos Factory guide from an earlier stage
locals {
  initial_image = "factory.talos.dev/installer/${var.talos_cluster_details.schematic_id}:${var.talos_cluster_details.version}"
}

# Generate the Talos client configuration
data "talos_client_configuration" "talosconfig" {
  cluster_name         = var.talos_cluster_details.name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for i, v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address]
  nodes                = [for i, v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address]
}

# Generate the controller configuration and instantiate the Initial Image for the Talos configuration
data "talos_machine_configuration" "machineconfig_controller" {
  cluster_name     = var.talos_cluster_details.name
  talos_version    = var.talos_cluster_details.version
  cluster_endpoint = "https://${tolist([for i, v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address])[0]}:6443"
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    templatefile("${path.module}/files/init_install_controller.tfmpl", {
      initial_image = local.initial_image
    }),
    templatefile("${path.module}/files/cilium_config.tfmpl", {
      cilium_cli_version = var.talos_cluster_details.cilium_cli_version
      cilium_version     = var.talos_cluster_details.cilium_version
    })
  ]
}

# Generate the worker configuration and instantiate the Initial Image for the Talos configuration
data "talos_machine_configuration" "machineconfig_worker" {
  cluster_name     = var.talos_cluster_details.name
  talos_version    = var.talos_cluster_details.version
  cluster_endpoint = "https://${tolist([for i, v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address])[0]}:6443"
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    templatefile("${path.module}/files/init_install_worker.tfmpl", {
      initial_image = local.initial_image
    })
  ]
}

# Check whether the Talos cluster is in a healthy state
data "talos_cluster_health" "cluster_health" {
  client_configuration = data.talos_client_configuration.talosconfig.client_configuration
  control_plane_nodes  = [for i, v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address]
  worker_nodes         = [for i, v in proxmox_vm_qemu.talos_vm_worker : v.default_ipv4_address]
  endpoints            = data.talos_client_configuration.talosconfig.endpoints
  # Include the Health Check timeout condition and remove the sleep condition in the main.tf file
  timeouts = {
    read = "10m"
  }
}