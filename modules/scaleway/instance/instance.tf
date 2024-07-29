locals {
  scaleway_size = {
    small  = "DEV1-S"
    medium = "PRO2-M"
    large  = "ENT1-L"
  }
  node_type = lookup(local.scaleway_size, var.size, var.default_size)
}

resource "scaleway_instance_ip" "ip" {
  zone = var.region
}

resource "scaleway_instance_server" "servers" {
  zone = var.region

  depends_on = [
    scaleway_instance_volume.server_volume,
    scaleway_instance_security_group.validator
  ]

  name  = var.name
  type  = local.node_type
  image = var.image

  root_volume {
    delete_on_termination = var.delete_on_termination
  }

  additional_volume_ids = [scaleway_instance_volume.server_volume.id]

  ip_id = scaleway_instance_ip.ip.id

  tags = var.tags

  user_data = var.user_data

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "scaleway_instance_volume" "server_volume" {
  type       = "b_ssd"
  name       = var.name
  size_in_gb = var.volume_size
}

resource "scaleway_instance_security_group" "validator" {
  inbound_default_policy  = "accept"
  outbound_default_policy = "accept"
}
