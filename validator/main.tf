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
  region          = var.default_region
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
    scaleway_instance_security_group.validator
  ]

  name  = "blonks-test-validator-${count.index}"
  type  = "PRO2-M"
  image = "ubuntu_jammy"

  root_volume {
    delete_on_termination = false
  }

  additional_volume_ids = [scaleway_instance_volume.server_volume[count.index].id]

  ip_id = scaleway_instance_ip.ip[count.index].id

  tags = ["node", "ramin&rene", "blonks"]

  user_data = {

    cloud-init = templatefile("${path.module}/../templates/cloud-init/validator.yml", {
      celestia_custom  = var.celestia_network
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      binary_release   = var.binary_release

      # validator rand chain specific stuff
      validator_name     = var.validator_name
      chain_id           = var.chain_id
      total_tia_amount   = var.total_tia_amount
      staking_tia_amount = var.staking_tia_amount
      key_name           = var.key_name
      keyring_backend    = var.keyring_backend
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
  name       = "blonks-test-validator-${count.index}"
  size_in_gb = var.volume_size
}

resource "scaleway_instance_security_group" "validator" {
  inbound_default_policy  = "accept"
  outbound_default_policy = "accept"
}
