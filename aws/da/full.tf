resource "aws_instance" "ec2_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp3"
    volume_size = 4000
  }

  tags = {
    Name = "blonks-da-ec2-instance"
  }

  security_groups = [aws_security_group.node.name, aws_security_group.ssh.name]

  user_data = templatefile("${path.module}/../templates/cloud-init/da.yml", {
    celestia_custom  = var.celestia_network
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
