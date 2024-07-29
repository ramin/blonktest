output "scaleway_instance_ips" {
  value = scaleway_instance_ip.ip[*].address
}

output "region_ip_map" {
  value = {
    for idx, region in var.regions : region => scaleway_instance_ip.ip[idx].address
  }
}
