# Include the root terragrunt configuration
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Include the environment variables
include "env" {
  path = "${get_terragrunt_dir()}/env_vars.hcl"
}

# Configure the terraform source
terraform {
  source = "../../aws"
}

# Input variables for the production environment
inputs = {
  project_name   = "cra-ucd-guide"
  domain_name    = "design.alpha.canada.ca"
  bucket_name    = "cra-ucd-guide-website-prod"
  aws_account_id = local.aws_account_id
  github_repo    = "cra-arc/cra-arc-ucdg-gcau"
  hosted_zone_id = "" # Will be populated after Route 53 zone is created

  common_tags = merge(local.common_tags, {
    Environment = "production"
  })
}