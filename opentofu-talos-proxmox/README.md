## Introduction

The repository is a showcase of the blog post found [here](https://blog.grosdouli.dev/blog/talos-on-proxmox-opentofu-part-1). The code allows users to create a Talos Kubernetes cluster on Proxmox 8.2.4. In the second part, we will describe how the code can be updated to install [Cilium](https://docs.cilium.io/en/stable/) as our CNI instead of flannel.

## Pre-prerequisites
1. Proxmox VE version >= 8.2.x
1. Proxmox Token
1. OpenTofu binary installed

## Execute OpenTofu Plan
**Note**: Identify your own way of exposing sensitive data before the plan execution. I am just reading files containing the sensitive data. Checkout the file [apikey.auto.tfvars](./apikey.auto.tfvars). Alertnatively, use an `.env` file and exclude it using the `.gitignore` file or use a secret management solution.

```bash
1. tofu init
2. tofu plan
3. tofu apply
```

## Retrieve Outputs

```bash
$ tofu output kubeconfig # kubeconfig reflects the output name defined in output.tf
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
| OpenTofu        | 1.8.1   | [OpenTofu Website](https://opentofu.org/)  