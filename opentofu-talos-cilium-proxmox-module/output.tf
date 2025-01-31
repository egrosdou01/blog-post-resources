output "kubeconfig" {
  value     = module.talos-cluster.kubeconfig
  sensitive = true
}

output "talos_configuration" {
  value     = module.talos-cluster.talos_configuration
  sensitive = true
}

output "client_configuration" {
  value     = module.talos-cluster.client_configuration
  sensitive = true
}