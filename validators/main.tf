module "validator-slow" {
  source = "../modules/scaleway/instance"
  name   = "blonks-test-validator-slow"
  size   = "large"
  tags   = ["node", "ramin", "blonks", "slow"]

  # provisioning
  user_data = {
    cloud-init = templatefile("${path.module}/../templates/cloud-init/validator.yml", {
      celestia_custom  = var.celestia_network
      core_ip          = var.core_ip
      metrics_endpoint = var.metrics_endpoint
      volume_size      = var.volume_size
      binary_release   = var.binary_release

      # validator specific stuff
      validator_name     = "slowmo-generator"
      chain_id           = "slow-blonks"
      total_tia_amount   = var.total_tia_amount
      staking_tia_amount = var.staking_tia_amount
      key_name           = var.key_name
      keyring_backend    = var.keyring_backend
    })
  }
}
