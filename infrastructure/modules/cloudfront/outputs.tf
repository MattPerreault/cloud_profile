output "arn" {
  description = "ARN of the distribution"
  value       = aws_cloudfront_distribution.s3_website_distribution.arn
}

output "domain" {
  description = "Domain name of the distribution"
  value       = aws_cloudfront_distribution.s3_website_distribution.domain_name
}
