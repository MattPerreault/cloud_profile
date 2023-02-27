variable "domain" {
  description = "S3 bucket regional domain name"
  type        = string
}

variable "domain_name" {
  description = "Domain name is the same as the s3 bucket name"
  type        = string
}

variable "cert_arn" {
  description = "ACM Certificate ARN"
  type        = string
}