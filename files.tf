locals {
  talos = {
    version      = "v1.8.3"
    schematic_ID = "ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515"
  }
}

resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  node_name               = "Proxmox"
  file_name               = "talos-${local.talos.version}-nocloud-amd64.img"
  url                     = "https://factory.talos.dev/image/${local.talos.schematic_ID}/${local.talos.version}/nocloud-amd64.raw.xz"
  decompression_algorithm = "zst"
  overwrite_unmanaged     = true
  overwrite               = false
}
