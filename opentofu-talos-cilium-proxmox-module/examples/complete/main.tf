module "talos-cluster" {
  source = "<Define the Git Repository where the code is stored>"

  # Specify the dequired credentials and permissions to access the Proxox server
  api_url          = var.api_url
  api_token_id     = var.api_token_id
  api_token_secret = var.api_token_secret

  # Specify the number of nodes to form the Talos Kubernetes cluster
  node = {
    controller01 = {
      vmodel       = "virtio"
      hdd_capacity = "10G"
      vmid         = 505
      vnetwork     = "vmbr3"
      vcores       = 2
      vram         = 2048
    }
    controller02 = {
      vmodel       = "virtio"
      hdd_capacity = "10G"
      vmid         = 506
      vnetwork     = "vmbr3"
      vcores       = 2
      vram         = 2048
    }
    worker01 = {
      vmodel       = "virtio"
      hdd_capacity = "10G"
      vmid         = 507
      vnetwork     = "vmbr3"
      vcores       = 2
      vram         = 2048
    }
    worker02 = {
      vmodel       = "virtio"
      hdd_capacity = "10G"
      vmid         = 508
      vnetwork     = "vmbr3"
      vcores       = 2
      vram         = 2048
    }
  }
}