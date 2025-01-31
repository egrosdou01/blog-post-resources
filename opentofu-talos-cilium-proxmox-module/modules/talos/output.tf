output "kubeconfig" {
  value     = talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive = true
}

output "client_configuration" {
  value     = data.talos_client_configuration.talosconfig.client_configuration
  sensitive = true
}

output "talos_configuration" {
  value     = data.talos_client_configuration.talosconfig.talos_config
  sensitive = true
}