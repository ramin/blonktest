locals {
  cidr = "10.0.0.0/16"

  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name

  cidr                                          = local.cidr
  enable_ipv6                                   = false
  public_subnet_assign_ipv6_address_on_creation = false

  azs = local.azs

  public_subnet_ipv6_native = false
  public_subnets            = [for k, v in local.azs : cidrsubnet(local.cidr, 8, k + 101)]

  private_subnets = [for k, v in local.azs : cidrsubnet(local.cidr, 8, k + 1)]

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  public_subnet_tags = {
    Tier = "public"
  }

  private_subnet_tags = {
    Tier = "private"
  }

  vpc_tags = {
    Purpose = "BrandArmy Platform and Applications"
  }
}
