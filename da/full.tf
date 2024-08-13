locals {
  celestia_custom = "${var.chain_id}:${var.genesis_hash}:${var.bridge_multiaddr[0]}"
}

module "da-full" {
  source      = "../modules/scaleway/instance"
  name        = "blonks-test-da-full-1"
  size        = "large"
  tags        = ["da", "blonks", "full"]
  region      = "nl-ams-3"
  volume_size = var.volume_size

  # provisioning
  user_data = {
    cloud-init = templatefile("${path.module}/../templates/cloud-init/da.yml", {
      celestia_custom  = local.celestia_custom
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      node_type        = "full"
      run_binary       = var.fast_binary_name
      fast_binary_name = var.fast_binary_name
      fast_binary_url  = var.fast_binary_url
      additional_flags = ""
    })
  }
}

# ?chain_id="dabbw"
# genesis_hash="D7729CA802EC0305E0A6926A6A248AD6132262A55452BF93225B6D53340ED8A5"
# bridge_multiaddr=[
#   # bridge 2
#   "/ip4/151.115.108.119/tcp/2121/p2p/12D3KooWJKaKtWvRwRfjotuv1n5idbVBvXCdz7wFY3qfuzMQMP39"
# ]


module "da-full-fresh" {
  source      = "../modules/scaleway/instance"
  name        = "blonks-test-da-full-fresh-sync"
  size        = "large"
  tags        = ["da", "blonks", "full"]
  region      = "nl-ams-3"
  volume_size = var.volume_size

  # provisioning
  user_data = {
    cloud-init = templatefile("${path.module}/../templates/cloud-init/da.yml", {
      celestia_custom  = "dabbw:D7729CA802EC0305E0A6926A6A248AD6132262A55452BF93225B6D53340ED8A5:/ip4/51.159.234.15/tcp/2121/p2p/12D3KooWNpubFfw31ZjowVYQwWG1J3fsCSr5Wc5Namh8QW9Dg5Bs"
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      node_type        = "full"
      run_binary       = var.fast_binary_name
      fast_binary_name = var.fast_binary_name
      fast_binary_url  = var.fast_binary_url
      additional_flags = ""
    })
  }
}


module "da-full-additional" {
  source      = "../modules/scaleway/instance"
  name        = "blonks-test-da-full-additional-sync"
  size        = "large"
  tags        = ["da", "blonks", "full"]
  region      = "nl-ams-3"
  volume_size = var.volume_size

  # provisioning
  user_data = {
    cloud-init = templatefile("${path.module}/../templates/cloud-init/da.yml", {
      celestia_custom  = "dabbw:D7729CA802EC0305E0A6926A6A248AD6132262A55452BF93225B6D53340ED8A5:/ip4/51.159.234.15/tcp/2121/p2p/12D3KooWNpubFfw31ZjowVYQwWG1J3fsCSr5Wc5Namh8QW9Dg5Bs"
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      node_type        = "full"
      run_binary       = var.fast_binary_name
      fast_binary_name = var.fast_binary_name
      fast_binary_url  = var.fast_binary_url
      additional_flags = ""
    })
  }
}


module "da-full-group" {
  count  = length(var.regions)
  region = var.regions[count.index]

  source        = "../modules/scaleway/instance"
  name          = "blonks-test-da-full-${var.regions[count.index]}-${count.index + 1}"
  instance_type = "PRO2-M"
  tags          = ["da", "blonks", "full"]

  volume_size = var.volume_size

  # provisioning
  user_data = {
    cloud-init = templatefile("${path.module}/../templates/cloud-init/da.yml", {
      celestia_custom  = local.celestia_custom
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      node_type        = "full"
      run_binary       = var.fast_binary_name
      fast_binary_name = var.fast_binary_name
      fast_binary_url  = var.fast_binary_url
      additional_flags = ""
    })
  }
}
