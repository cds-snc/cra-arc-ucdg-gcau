variable "account_id" {
  description = "(Required) The account ID to perform actions on."
  type        = string
}

variable "billing_tag_key" {
  description = "(Optional, default 'CostCentre') Name of the billing tag."
  type        = string
  default     = "CostCentre"
}

variable "billing_tag_value" {
  description = "(Required) Value of the billing tag."
  type        = string
}

variable "billing_code" {
  description = "(Required) Value of the billing tag."
  type        = string
}

variable "domain_name" {
  description = "The root domain name, e.g., cra-arc.alpha.canada.ca."
  type        = string
}
variable "subdomain_name" {
  description = "The subdomain for design, e.g., design.cra-arc.alpha.canada.ca."
  type        = string
}

variable "env" {
  description = "The current running environment"
  type        = string
}

variable "product_name" {
  description = "(Required) The name of the product you are deploying."
  type        = string
}

variable "region" {
  description = "The current AWS region"
  type        = string
}
