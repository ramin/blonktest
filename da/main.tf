terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
}


resource "scaleway_instance_security_group" "da" {
  inbound_default_policy  = "accept"
  outbound_default_policy = "accept"
}
