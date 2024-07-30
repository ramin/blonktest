variable "scaleway_access_key" {}

variable "scaleway_secret_key" {}

variable "scaleway_organization_id" {}

variable "scaleway_project_id" {}

variable "default_region" {
  default = "nl-ams-3"
}

variable "light_nodes" {
  type = list(string)
  default = [
    "fr-par-2",
    "nl-ams-3",
    "pl-waw-3"
  ]

}

variable "full_nodes" {
  type = list(string)
  default = [
    "fr-par-2",
    # "nl-ams-3",
    # "pl-waw-3"
  ]
}

variable "pruned_full_nodes" {
  type = list(string)
  default = [
    "fr-par-2",
    "nl-ams-3",
    "pl-waw-3",
  ]
}

variable "pruned_light_nodes" {
  type = list(string)
  default = [
    "fr-par-2",
    "nl-ams-3",
    "pl-waw-3",
  ]
}

// add a new region for each bridge we want to launch
variable "regions" {
  type = list(string)
  default = [
    "fr-par-2",
    "nl-ams-3",
    "pl-waw-3",
  ]
}

variable "instance_sizes" {
  type = map(string)
  default = {
    full   = "PRO2-L"
    pruned = "PRO2-M"
    light  = "DEV1-S"
  }
  description = "Map of instance sizes for different node types"
}

variable "celestia_network" {
  type        = string
  default     = "mocha"
  description = "the celestia p2p.network to connect to"
}

variable "core_ip" {
  type        = string
  description = "the celestia p2p.network to connect to"
}

variable "metrics_endpoint" {
  type        = string
  description = "the metrics endpoint to use"
}

variable "volume_size" {
  type        = number
  default     = 1800
  description = "the size of the bridge's volume in GB"
}

variable "fast_binary_url" {
  type        = string
  description = "remote location to define custom binary"
}

variable "fast_binary_name" {
  type        = string
  description = "name-to-save-fast-binary-as"
}

variable "run_binary" {
  type        = string
  default     = "celestia"
  description = "name of the binary to run"
}
