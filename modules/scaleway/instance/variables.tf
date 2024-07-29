variable "region" {
  type        = string
  default     = "nl-ams-3"
  description = "the region to be in"
}

variable "size" {
  type        = string
  description = "The size of the node (small, medium, large)"
  default     = "medium"
  validation {
    condition     = contains(["small", "medium", "large"], var.size)
    error_message = "Size must be one of 'small', 'medium', or 'large'."
  }
}

variable "default_size" {
  type        = string
  description = "The default size of the node"
  default     = "PRO2-M"
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

variable "image" {
  type        = string
  default     = "ubuntu_jammy"
  description = "The image to be used for the node"
}

variable "delete_on_termination" {
  type        = bool
  default     = false
  description = "Whether to delete the node on termination"
}

variable "name" {
  type        = string
  default     = "default-node-name"
  description = "The name of the node"
}

variable "user_data" {
  type        = map(any)
  description = "The user data to be passed to the node"
}

variable "volume_size" {
  type        = number
  default     = 1000
  description = "the size of the node volume in GB"
}

variable "tags" {
  type        = list(string)
  description = "A list of tags to apply to the node"
}
