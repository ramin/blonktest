resource "scaleway_instance_ip" "ip" {
  count = length(var.full_nodes)
  zone  = var.full_nodes[count.index]
}

resource "scaleway_instance_server" "servers" {
  count = length(var.full_nodes)
  zone  = var.full_nodes[count.index]

  depends_on = [
    scaleway_instance_volume.server_volume,
    scaleway_instance_security_group.full
  ]

  name  = "full-archival-${count.index}"
  type  = "PRO2-M"
  image = "ubuntu_jammy"

  root_volume {
    delete_on_termination = false
  }

  additional_volume_ids = [scaleway_instance_volume.server_volume[count.index].id]

  ip_id = scaleway_instance_ip.ip[count.index].id

  tags = ["node", "ramin&rene", "blonks"]

  user_data = {

    cloud-init = templatefile("${path.module}/../templates/cloud-init/da.yml", {
      node_type        = "full"
      celestia_custom  = var.celestia_network
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      fast_binary_url  = var.fast_binary_url
      fast_binary_name = var.fast_binary_name

      # run with fast block binary to start
      run_binary = var.fast_binary_name
    })
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "scaleway_instance_volume" "server_volume" {
  count      = length(var.full_nodes)
  zone       = var.full_nodes[count.index]
  type       = "b_ssd"
  name       = "full-archival-${count.index}"
  size_in_gb = var.volume_size
}
