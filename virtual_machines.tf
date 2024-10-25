resource "proxmox_virtual_environment_vm" "talos_cp_01" {
  name        = "talos-cp-01"
  description = "Managed by Terraform"
  tags        = ["terraform"]
  node_name   = "Proxmox"
  on_boot     = true
  bios        = "ovmf"
  boot_order  = ["scsi0"]
  # machine       = "q35"
  # scsi_hardware = "virtio-scsi-single"
  # bios          = "seabios"

  cpu {
    cores = 1
    type  = "x86-64-v2-AES"
  }
  memory {
    dedicated = 1024
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-zfs"
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = 20
  }
  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    interface    = "scsi0"
    datastore_id = "local-zfs"
    ip_config {
      ipv4 {
        address = "${var.talos_cp_01_ip_addr}/24"
        gateway = var.default_gateway
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "talos_worker_01" {
  depends_on    = [proxmox_virtual_environment_vm.talos_cp_01]
  name          = "talos-worker-01"
  description   = "Managed by Terraform"
  tags          = ["terraform"]
  node_name     = "Proxmox"
  on_boot       = true
  boot_order    = ["scsi0"]
  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"
  bios          = "seabios"


  cpu {
    cores = 1
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = 1024
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "bulk"
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "scsi0"
    size         = 20
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    interface    = "scsi0"
    datastore_id = "local-zfs"
    ip_config {
      ipv4 {
        address = "${var.talos_worker_01_ip_addr}/24"
        gateway = var.default_gateway
      }
    }
  }
}
