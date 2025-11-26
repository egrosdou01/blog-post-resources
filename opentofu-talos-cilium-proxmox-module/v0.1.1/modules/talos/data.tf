# Define the Initial Image copied from the Talos Factory
locals {
  initial_image = "factory.talos.dev/installer/${var.talos_cluster_details.schematic_id}:${var.talos_cluster_details.version}"
}

# Generate the Talos client configuration
data "talos_client_configuration" "talosconfig" {
  for_each     = var.clusters
  cluster_name = each.key

  client_configuration = talos_machine_secrets.this[each.key].client_configuration

  endpoints = [
    for i, v in local.all_clusters :
    proxmox_vm_qemu.talos_nodes[i].default_ipv4_address
    if v.cluster_name == each.key && can(regex("controller", lower(v.node_name)))
  ]

  nodes = [
    for i, v in local.all_clusters :
    proxmox_vm_qemu.talos_nodes[i].default_ipv4_address
    if v.cluster_name == each.key && can(regex("controller", lower(v.node_name)))
  ]
}

# Generate and instantiate the Controller configuration
data "talos_machine_configuration" "machineconfig" {
  for_each = local.all_clusters

  cluster_name  = each.value.cluster_name
  talos_version = var.talos_cluster_details.version

  cluster_endpoint = "https://${tolist([
    for i, v in local.all_clusters :
    proxmox_vm_qemu.talos_nodes[i].default_ipv4_address
    if v.cluster_name == each.value.cluster_name && can(regex("controller", lower(v.node_name)))
  ])[0]}:6443"

  machine_secrets = talos_machine_secrets.this[each.value.cluster_name].machine_secrets

  machine_type = can(regex("controller", lower(each.value.node_name))) ? "controlplane" : "worker"

  config_patches = can(regex("controller", lower(each.value.node_name))) ? [
    templatefile("${path.module}/files/init_install_controller.tfmpl", {
      initial_image = "factory.talos.dev/installer/${var.talos_cluster_details.schematic_id}:${var.talos_cluster_details.version}"
    }),
    templatefile("${path.module}/files/cilium_config.tfmpl", {
      cilium_cli_version = var.talos_cluster_details.cilium_cli_version
      cilium_version     = var.talos_cluster_details.cilium_version
    })
    ] : [
    templatefile("${path.module}/files/init_install_worker.tfmpl", {
      initial_image = "factory.talos.dev/installer/${var.talos_cluster_details.schematic_id}:${var.talos_cluster_details.version}"
    })
  ]
}

# Check Talos cluster healthy state
data "talos_cluster_health" "cluster_health" {
  for_each = var.clusters

  client_configuration = data.talos_client_configuration.talosconfig[each.key].client_configuration

  control_plane_nodes = [
    for i, v in local.all_clusters :
    proxmox_vm_qemu.talos_nodes[i].default_ipv4_address
    if v.cluster_name == each.key && can(regex("controller", lower(v.node_name)))
  ]
  worker_nodes = [
    for i, v in local.all_clusters :
    proxmox_vm_qemu.talos_nodes[i].default_ipv4_address
    if v.cluster_name == each.key && can(regex("worker", lower(v.node_name)))
  ]

  endpoints = [
    for i, v in local.all_clusters :
    proxmox_vm_qemu.talos_nodes[i].default_ipv4_address
    if v.cluster_name == each.key && can(regex("controller", lower(v.node_name)))
  ]
  # skip_kubernetes_checks = true
  timeouts = {
    read = "20m"
  }
}