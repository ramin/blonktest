module "da-full" {
  source = "../modules/scaleway/instance"
  name   = "blonks-test-da-full-1"
  size   = "large"
  tags   = ["da", "blonks", "full"]

  # provisioning
  user_data = {
    cloud-init = templatefile("${path.module}/../templates/cloud-init/da.yml", {
      celestia_custom  = var.celestia_network
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      node_type        = "full"
    })
  }
}
