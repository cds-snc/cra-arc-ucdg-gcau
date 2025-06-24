# Root Terragrunt configuration
# This file contains common configuration for all environments

locals {
  # Common tags to apply to all resources
  common_tags = {
    Project     = "cra-ucd-guide"
    Environment = get_env("TG_ENV", "unknown")
    ManagedBy   = "terragrunt"
  }
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "cra-ucd-guide-terraform-state-${get_env("TG_ENV", "dev")}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "cra-ucd-guide-terraform-locks-${get_env("TG_ENV", "dev")}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
  
  default_tags {
    tags = {
      Project     = "cra-ucd-guide"
      Environment = "${get_env("TG_ENV", "unknown")}"
      ManagedBy   = "terragrunt"
    }
  }
}

# US East 1 provider for CloudFront certificates
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
  
  default_tags {
    tags = {
      Project     = "cra-ucd-guide"
      Environment = "${get_env("TG_ENV", "unknown")}"
      ManagedBy   = "terragrunt"
    }
  }
}
EOF
}