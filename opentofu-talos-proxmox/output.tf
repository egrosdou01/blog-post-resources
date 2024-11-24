# Retrieve the Kubeconfig of the file
output "kubeconfig" {
  value     = resource.talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive = true
}

# Retrieve the Client Configuration of the Talos Cluster
output "client_configuration" {
  value     = data.talos_client_configuration.talosconfig.client_configuration
  sensitive = true
}

# Retrieve the Talos configuration in case you would like to interact with the `talosctl`
output "talos_configuration" {
  value     = data.talos_client_configuration.talosconfig.talos_config
  sensitive = true
}