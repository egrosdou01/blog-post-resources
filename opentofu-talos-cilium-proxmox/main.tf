# Generate machine secrets for Talos cluster
resource "talos_machine_secrets" "this" {
  talos_version = var.talos_cluster_details.version
}

# Apply the machine configuration created in the data section for the controller node
resource "talos_machine_configuration_apply" "controller_config_apply" {
  for_each                    = { for i, v in proxmox_vm_qemu.talos_vm_controller : i => v }
  depends_on                  = [proxmox_vm_qemu.talos_vm_controller]
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_controller.machine_configuration
  node                        = each.value.default_ipv4_address
}

# Apply the machine configuration created in the data section for the worker node
resource "talos_machine_configuration_apply" "worker_config_apply" {
  for_each                    = { for i, v in proxmox_vm_qemu.talos_vm_worker : i => v }
  depends_on                  = [proxmox_vm_qemu.talos_vm_worker]
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_worker.machine_configuration
  node                        = each.value.default_ipv4_address
}

# Start the bootstraping of the cluster
resource "talos_machine_bootstrap" "bootstrap" {
  depends_on           = [talos_machine_configuration_apply.controller_config_apply]
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = tolist([for v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address])[0]
}

# Collect the kubeconfig of the Talos cluster created
resource "talos_cluster_kubeconfig" "kubeconfig" {
  depends_on           = [talos_machine_bootstrap.bootstrap, data.talos_cluster_health.cluster_health]
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = tolist([for v in proxmox_vm_qemu.talos_vm_controller : v.default_ipv4_address])[0]
}
