output "scaleway_instance_ip" {
  value = scaleway_instance_ip.ip.address
}

output "scaleway_instance_server_id" {
  value = scaleway_instance_server.servers.id
}

output "scaleway_instance_server_name" {
  value = scaleway_instance_server.servers.name
}

output "scaleway_instance_server_type" {
  value = scaleway_instance_server.servers.type
}

output "scaleway_instance_server_image" {
  value = scaleway_instance_server.servers.image
}

output "scaleway_instance_server_volume_id" {
  value = scaleway_instance_volume.server_volume.id
}

output "scaleway_instance_server_volume_size" {
  value = scaleway_instance_volume.server_volume.size_in_gb
}

output "scaleway_instance_security_group_id" {
  value = scaleway_instance_security_group.validator.id
}
