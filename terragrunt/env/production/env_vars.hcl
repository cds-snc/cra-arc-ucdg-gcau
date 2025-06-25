# Environment-specific variables for production

locals {
  environment    = "production"
  aws_account_id = "211125499457" # Replace with actual AWS account ID

  common_tags = {
    Project     = "cra-ucd-guide"
    Environment = "production"
    ManagedBy   = "terragrunt"
    CostCentre  = "cra-arc"
  }
}