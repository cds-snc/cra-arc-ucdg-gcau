# IAM Role definitions for static website deployment

# Policy for GitHub Actions to assume deployment role
data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo}:*"]
    }
  }
}

# Policy for S3 and CloudFront deployment operations
data "aws_iam_policy_document" "static_website_deployment" {
  statement {
    sid    = "AllowS3Operations"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning"
    ]
    resources = [
      var.s3_bucket_arn,
      "${var.s3_bucket_arn}/*"
    ]
  }

  statement {
    sid    = "AllowCloudFrontInvalidation"
    effect = "Allow"
    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetInvalidation",
      "cloudfront:ListInvalidations"
    ]
    resources = [var.cloudfront_distribution_arn]
  }
}

# IAM role for deployment
resource "aws_iam_role" "deployment_role" {
  name               = "${var.project_name}-deployment-role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  tags = var.common_tags
}

# IAM policy for static website deployment
resource "aws_iam_policy" "static_website_deployment" {
  name        = "${var.project_name}-deployment-policy"
  description = "Policy for ${var.project_name} static website deployment"
  policy      = data.aws_iam_policy_document.static_website_deployment.json

  tags = var.common_tags
}

# Attach deployment policy to role
resource "aws_iam_role_policy_attachment" "deployment_policy_attachment" {
  role       = aws_iam_role.deployment_role.name
  policy_arn = aws_iam_policy.static_website_deployment.arn
}