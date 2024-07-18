terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
}

provider "scaleway" {
  access_key      = var.scaleway_access_key
  secret_key      = var.scaleway_secret_key
  organization_id = var.scaleway_organization_id
  project_id      = var.scaleway_project_id
}

resource "scaleway_instance_ip" "ip" {
  count = length(var.regions)
  zone  = var.regions[count.index]
}

resource "scaleway_instance_server" "servers" {
  count = length(var.regions)
  zone  = var.regions[count.index]

  depends_on = [
    scaleway_instance_volume.server_volume,
    scaleway_instance_security_group.bridges
  ]

  name  = "blonks-test-bridge-${count.index}"
  type  = "PRO2-M"
  image = "ubuntu_jammy"

  root_volume {
    delete_on_termination = false
  }

  additional_volume_ids = [scaleway_instance_volume.server_volume[count.index].id]

  ip_id = scaleway_instance_ip.ip[count.index].id

  tags = ["node", "ramin&rene", "blonks"]

  user_data = {

    cloud-init = templatefile("${path.module}/../templates/cloud-init/bridge.yml", {
      celestia_custom  = var.celestia_network
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      fast_binary_url  = var.fast_binary_url
      fast_binary_name = var.fast_binary_name
    })
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "scaleway_instance_volume" "server_volume" {
  count      = length(var.regions)
  zone       = var.regions[count.index]
  type       = "b_ssd"
  name       = "blonks-test-bridge-${count.index}"
  size_in_gb = var.volume_size
}

resource "scaleway_instance_security_group" "bridges" {
  inbound_default_policy  = "accept"
  outbound_default_policy = "accept"
}
