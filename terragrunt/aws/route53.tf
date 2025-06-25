# Route 53 hosted zone for the domain

resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = var.common_tags
}
