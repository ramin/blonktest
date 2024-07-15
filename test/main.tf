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

resource "scaleway_instance_server" "servers" {
  name              = "ramin-provision-test"
  type              = "PRO2-M"
  image             = "ubuntu_jammy"
  security_group_id = scaleway_instance_security_group.bridges.id

  root_volume {
    size_in_gb = 50
  }

  zone = var.default_region


  tags = ["node", "ramin&rene", "blonks"]

  provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/vdb",
      "sudo mkdir -p /mnt/data",
      "sudo mount /dev/vdb /mnt/data",
      "sudo apt-get update",
      "sudo apt-get install -y golang git",
      "sudo mkdir -p /mnt/data/celestia/celestia-node",
      "sudo wget https://github.com/celestiaorg/celestia-node/releases/download/v0.14.0/celestia-node_Linux_x86_64.tar.gz -O /mnt/data/celestia/celestia-node.tar.gz",
      "sudo tar -xzf /mnt/data/celestia/celestia-node.tar.gz -C /mnt/data/celestia/celestia-node",
      "sudo /mnt/data/celestia/celestia-node bridge init --node-store /mnt/data/celestia-bridge > /mnt/data/celestia/init.txt",

      ## need to set --core.ip and --metrics
      "sudo /mnt/data/celestia/celestia-node bridge start --node-store /mnt/data/celestia-bridge",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_ed25519")
      host        = self.public_ip
    }
  }
}

resource "scaleway_instance_volume" "server_volume" {
  type       = "l_ssd"
  name       = "ramin-blonk-test"
  size_in_gb = 8000
  zone       = var.default_region
}


resource "scaleway_instance_security_group" "bridges" {
  inbound_default_policy  = "accept"
  outbound_default_policy = "accept"
}
