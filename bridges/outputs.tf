output "scaleway_instance_server_ids" {
  value = scaleway_instance_server.servers[*].id
}

output "scaleway_instance_server_ips" {
  value = scaleway_instance_ip.ip[*].address
}

output "scaleway_instance_server_names" {
  value = scaleway_instance_server.servers[*].name
}

output "scaleway_instance_server_zones" {
  value = scaleway_instance_server.servers[*].zone
}
