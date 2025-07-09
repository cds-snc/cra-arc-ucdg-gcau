# Set the environment's global variables
#
inputs = {
  account_id   = "211125499457"
  domain_name  = "cra-arc.alpha.canada.ca" # to test in your scratch account, use this domain: scratch-[name].cra-arc-ucdg-gcau.cdssandbox.xyz
  env          = "dev"                     #devscratch - s3 requires a globally unique name, replace dev with devscratch to create a unique s3 bucket
  product_name = "cra-arc-ucdg-gcau"
  region       = "ca-central-1"
  stage_name   = "v1"
}
