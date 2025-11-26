# Collect each kubeconfig per Talos cluster definition
output "kubeconfig" {
  description = "Kubeconfig"
  value = {
    for cluster, cfg in talos_cluster_kubeconfig.kubeconfig : cluster => cfg.kubeconfig_raw
  }
}

# Collect each client configuration per Talos cluster definition
output "client_configuration" {
  description = "Talos client configuration"
  value = {
    for cluster, cfg in data.talos_client_configuration.talosconfig : cluster => cfg.client_configuration
  }
}

# Collect each Talos configuration per Talos cluster definition
output "talos_configuration" {
  description = "Full Talos configuration"
  value = {
    for cluster, cfg in data.talos_client_configuration.talosconfig : cluster => cfg.talos_config
  }
}
