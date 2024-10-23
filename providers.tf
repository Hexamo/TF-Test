terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.2"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.5.0"
    }
  }
}
