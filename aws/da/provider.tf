terraform {
  required_version = ">= 1.5.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.62"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
