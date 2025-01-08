# Define the Initial Image link copied from the Talos Factory guide from an earlier stage
locals {
  initial_image = "factory.talos.dev/installer/${var.talos_cluster_details.schematic_id}:${var.talos_cluster_details.version}"
}

# Generate the Talos client configuration
data "talos_client_configuration" "talosconfig" {
  cluster_name         = var.talos_cluster_details.name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address]
  nodes                = [for v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address]
}

# Generate the controller configuration and instantiate the Initial Image for the Talos configuration
data "talos_machine_configuration" "machineconfig_controller" {
  cluster_name     = var.talos_cluster_details.name
  talos_version    = var.talos_cluster_details.version
  cluster_endpoint = "https://${tolist([for v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address])[0]}:6443"
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    templatefile("${path.module}/files/init_install.tfmpl", {
      initial_image = local.initial_image
  })]
}

# Generate the worker configuration and instantiate the Initial Image for the Talos configuration
data "talos_machine_configuration" "machineconfig_worker" {
  cluster_name     = var.talos_cluster_details.name
  talos_version    = var.talos_cluster_details.version
  cluster_endpoint = "https://${tolist([for v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address])[0]}:6443"
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    templatefile("${path.module}/files/init_install.tfmpl", {
      initial_image = local.initial_image
  })]
}

# Check whether the Talos cluster is in a healthy state
data "talos_cluster_health" "cluster_health" {
  depends_on           = [null_resource.wait_for_agent]
  client_configuration = data.talos_client_configuration.talosconfig.client_configuration
  control_plane_nodes  = [for v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address]
  worker_nodes         = [for v in proxmox_vm_qemu.talos_vm_worker : v.default_ipv4_address]
  endpoints            = data.talos_client_configuration.talosconfig.endpoints
}