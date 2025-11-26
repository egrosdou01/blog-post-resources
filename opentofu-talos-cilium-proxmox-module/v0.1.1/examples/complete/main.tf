module "talos-cluster" {
  source = "<Define the Git Repository where the code is stored>"

  # Specify the dequired credentials and permissions to access the Proxox server
  api_url          = var.api_url
  api_token_id     = var.api_token_id
  api_token_secret = var.api_token_secret

  # Specify the number of nodes to form the Talos Kubernetes cluster
  clusters = {
    "cluster1" = {
      nodes = {
        "controller01" = {
          id           = 0
          vmodel       = "virtio"
          hdd_capacity = "10G"
          vmid         = 105
          vnetwork     = "vmbr3"
          vcores       = 2
          vram         = 2048
        },
        "worker01" = {
          id           = 0
          vmodel       = "virtio"
          hdd_capacity = "10G"
          vmid         = 106
          vnetwork     = "vmbr3"
          vcores       = 2
          vram         = 2048
        }
      }
    },
    "cluster2" = {
      nodes = {
        "controller01" = {
          id           = 0
          vmodel       = "virtio"
          hdd_capacity = "10G"
          vmid         = 107
          vnetwork     = "vmbr3"
          vcores       = 2
          vram         = 2048
        },
        "worker01" = {
          id           = 0
          vmodel       = "virtio"
          hdd_capacity = "10G"
          vmid         = 108
          vnetwork     = "vmbr3"
          vcores       = 2
          vram         = 2048
        }
      }
    }
  }
}