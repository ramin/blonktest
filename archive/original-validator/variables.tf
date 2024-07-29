variable "scaleway_access_key" {}

variable "scaleway_secret_key" {}

variable "scaleway_organization_id" {}

variable "scaleway_project_id" {}

variable "default_region" {
  default = "nl-ams"
}

// add a new region for each bridge we want to launch
variable "regions" {
  type = list(string)
  default = [
    "nl-ams-3",
    "fr-par-2",
    "pl-waw-3",
  ]
}

variable "volume_size" {
  type        = number
  default     = 8000
  description = "the size of the bridge's volume in GB"
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

variable "binary_release" {
  type        = string
  description = "the release of the celestia binary to use"
}

variable "run_binary" {
  type        = string
  default     = "celestia"
  description = "name of the binary to run (defaults to celestia but can use another if custom is on system)"
}

## validator specific
variable "validator_name" {
  type        = string
  description = "the name of the validator"
}

variable "chain_id" {
  type        = string
  description = "the chain ID for the celestia network"
}

variable "total_tia_amount" {
  type        = string
  default     = "19910500500000000utia"
  description = "the total TIA amount for the genesis account"
}

variable "staking_tia_amount" {
  type        = string
  default     = "10500000000utia"
  description = "the staking TIA amount for the genesis account"
}

variable "key_name" {
  type        = string
  default     = "validator"
  description = "the key name for the celestia account"
}

variable "keyring_backend" {
  type        = string
  default     = "test"
  description = "the keyring backend to use"
}
