# Environment-specific variables for staging

locals {
  environment    = "staging"
  aws_account_id = "211125499457" # Replace with actual AWS account ID

  common_tags = {
    Project     = "cra-ucd-guide"
    Environment = "staging"
    ManagedBy   = "terragrunt"
    CostCentre  = "cra-arc"
  }
}