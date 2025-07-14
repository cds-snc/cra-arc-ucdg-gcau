module "website" {
  source                  = "github.com/cds-snc/terraform-modules//simple_static_website?ref=v10.0.0"
  domain_name_source      = var.subdomain_name
  billing_tag_value       = var.billing_code
  s3_bucket_name          = "cra-arc-ucdg-gcau-static-website-${var.env}"
  force_destroy_s3_bucket = true
  index_document          = "index.html"
  single_page_app         = false
  is_create_hosted_zone   = true



  providers = {
    aws           = aws
    aws.dns       = aws # For scenarios where there is a dedicated DNS provder.
    aws.us-east-1 = aws.us-east-1
  }
}
