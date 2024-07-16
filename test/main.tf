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
  zone = var.default_region
}

resource "scaleway_instance_server" "servers" {
  depends_on = [
    scaleway_instance_volume.server_volume,
    scaleway_instance_security_group.bridges
  ]

  name  = "ramin-provision-test"
  type  = "PRO2-M"
  image = "ubuntu_jammy"

  root_volume {
    delete_on_termination = false
  }

  additional_volume_ids = [scaleway_instance_volume.server_volume.id]

  ip_id = scaleway_instance_ip.ip.id

  zone = var.default_region

  tags = ["node", "ramin&rene", "blonks"]

  user_data = {

    cloud-init = templatefile("${path.module}/cloud-init.yml", {
      celestia_custom  = var.celestia_network
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
    })
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "scaleway_instance_volume" "server_volume" {
  type       = "b_ssd"
  name       = "ramin-blonk-test"
  size_in_gb = 800
  zone       = var.default_region
}

resource "scaleway_instance_security_group" "bridges" {
  inbound_default_policy  = "accept"
  outbound_default_policy = "accept"
}
