locals {
  talos = {
    version      = "v1.7.4"
    schematic_ID = "ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515"
  }
}

resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  content_type            = "iso"
  datastore_id            = "local"
  node_name               = "Tycho"
  file_name               = "talos-${local.talos.version}-nocloud-amd64.img"
  url                     = "https://factory.talos.dev/image/${local.talos.schematic_ID}/${local.talos.version}/metal-amd64.raw.zst"
  decompression_algorithm = "zst"
  overwrite               = false
}
