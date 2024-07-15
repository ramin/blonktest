variable "scaleway_access_key" {}

variable "scaleway_secret_key" {}

variable "scaleway_organization_id" {}

variable "scaleway_project_id" {}

variable "default_region" {
  default = "nl-ams-3"
}

// add a new region for each bridge we want to launch
variable "regions" {
  type = list(string)
  default = [
    "fr-par-2",
    "nl-ams-3",
    "pl-waw-1",
  ]
}

variable "volume_size" {
  type        = number
  default     = 8000
  description = "the size of the bridge's volume in GB"
}
