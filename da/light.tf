locals {
  light_node_volume_size = 750
}

module "da-light-no-pruning" {
  count  = length(var.light_nodes)
  region = var.regions[count.index]

  source        = "../modules/scaleway/instance"
  name          = "blonks-test-da-light-no-pruning-${var.regions[count.index]}-${count.index + 1}"
  instance_type = "PRO2-S"
  tags          = ["da", "blonks", "light"]

  volume_size = local.light_node_volume_size

  # provisioning
  user_data = {
    cloud-init = templatefile("${path.module}/../templates/cloud-init/da.yml", {
      celestia_custom  = local.celestia_custom
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = local.light_node_volume_size
      node_type        = "light"
      run_binary       = var.fast_binary_name
      fast_binary_name = var.fast_binary_name
      fast_binary_url  = var.fast_binary_url
      additional_flags = ""
    })
  }
}
