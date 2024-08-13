variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair"
}

variable "ami" {
  type        = string
  description = "The AMI ID"
}

variable "instance_type" {
  type        = string
  description = "The instance type"
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
  default     = 6000
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

variable "chain_id" {
  type        = string
  description = "list of chain IDs"
}

variable "genesis_hash" {
  type        = string
  description = "genesis hash"
}

variable "bridge_multiaddr" {
  type        = list(string)
  description = "list of bridge multiaddresses"
  default     = []
}
