terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.AWS_REGION
  default_tags {
    tags = {
      Owner     = "Craig"
      ManagedBy = "Terraform"
      Project   = "Ent-Services"
    }
  }
}
