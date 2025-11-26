<!-- BEGIN_TF_DOCS -->
# Terraform Talos Cluster Creation

[TOC]

## Introduction

The repository is a showcase of the blog post found [here](https://blog.grosdouli.dev/blog/talos-on-proxmox-opentofu-part-4). The code allows users to create multiple Talos Kubernetes clusters on Proxmox 8.2.4 powered by [Cilium](https://docs.cilium.io/en/stable/). Cilium kube-proxy replacement alongside Gateway API capabilities are enabled. More information about the Cilium setup, have a look at the directory `modules/talos/files/init_install_controller.tfmpl`.

In the 5th part of the series, we introduce [Longhorn](https://longhorn.io/) as a distributed block storage.

The code now is converted into a module to be reusable by multiple users following GitOps approaches.

## Pre-prerequisites
1. Proxmox version 8.2.x or greater
1. Proxmox Token
1. OpenTofu binary installed

## Execute OpenTofu Plan
Note: Identify your own way of exposing sensitive variables before the execution of the plan.

```bash
1. tofu init
2. tofu plan
3. tofu apply
```

## Delete Resources

```bash
$ tofu destroy
```

## Tested Versions
| SOFTWARE        | VERSION | DOCS                                                                 |
|:----------------|:--------|:----------------------------------------------------------------------|
| Proxmox VE      | 8.2.4   | [Proxmox VE Overview](https://www.proxmox.com/en/proxmox-virtual-environment/overview) |
| Talos Provider  | 0.8.1   | [Talos Provider Docs](https://search.opentofu.org/provider/siderolabs/talos/v0.6.1) |
| Talos Linux     | 1.11.3   | [Talos Linux Release](https://github.com/siderolabs/talos/releases/tag/v1.8.1) |
| OpenTofu        | 1.8.1   | [OpenTofu Website](https://opentofu.org/)                             |

```

## Example of usage

```hcl
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.1 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.2-rc04 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.2 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.8.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | The Proxmox API URL | `string` | n/a | yes |
| <a name="input_api_token_id"></a> [api\_token\_id](#input\_api\_token\_id) | The Proxmox API Toke ID | `string` | n/a | yes |
| <a name="input_api_token_secret"></a> [api\_token\_secret](#input\_api\_token\_secret) | The Proxmox API Toke Secret | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
| <a name="output_talos_configuration"></a> [talos\_configuration](#output\_talos\_configuration) | n/a |
| <a name="output_client_configuration"></a> [client\_configuration](#output\_client\_configuration) | n/a |
<!-- END_TF_DOCS -->