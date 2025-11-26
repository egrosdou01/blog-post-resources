<!-- BEGIN_TF_DOCS -->
# Terraform Talos Cluster Creation

## Introduction

The repository is a showcase of the blog post found [here](https://blog.grosdouli.dev/blog/talos-on-proxmox-opentofu-part-3).
The code allows users to create a Talos Kubernetes cluster on Proxmox `8.2.4`. The code is converted into a module for reusability. It allows users to follow a GitOps approach towards Talos Kubernetes cluster deployments.

## Pre-prerequisites

1. Proxmox version 8.2.x or greater
1. Proxmox Token
1. OpenTofu binary installed

## Example creds/ Directory

The `creds/` directory contains three files, `api_token_id.txt`, `api_token_secret.txt`, and `api_url.txt`. The files look like the one below.

```bash
$ cat creds/api_token_id.txt
testuser@pam!tofu-talos

$ cat api_token_secret.txt
123abcde-4567-8910-1112-1314fghijklm

$ cat api_url.txt
https://<Proxmox FQDN>:<Proxmox Port>/api2/json
```

If you are unaware of how to get these values, go through [part 1](https://blog.grosdouli.dev/blog/talos-on-proxmox-opentofu-part-1) of the series.

## Execute OpenTofu Plan

Note: Identify your way of exposing sensitive variables before the execution of the plan.

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
| Talos Provider  | 0.6.1   | [Talos Provider Docs](https://search.opentofu.org/provider/siderolabs/talos/v0.6.1) |
| Talos Linux     | 1.8.1   | [Talos Linux Release](https://github.com/siderolabs/talos/releases/tag/v1.8.1) |
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.1 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.1-rc4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.2 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.6.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | Proxmox API URL | `string` | n/a | yes |
| <a name="input_api_token_id"></a> [api\_token\_id](#input\_api\_token\_id) | Proxmox API Toke ID | `string` | n/a | yes |
| <a name="input_api_token_secret"></a> [api\_token\_secret](#input\_api\_token\_secret) | Proxmox API Toke Secret | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
| <a name="output_talos_configuration"></a> [talos\_configuration](#output\_talos\_configuration) | n/a |
| <a name="output_client_configuration"></a> [client\_configuration](#output\_client\_configuration) | n/a |
<!-- END_TF_DOCS -->