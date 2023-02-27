output "arn" {
  description = "ARN of the distribution"
  value       = aws_cloudfront_distribution.s3_distribution.arn
}

output "domain" {
  description = "Domain name of the distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "hosted_zone" {
  description = "Route53 zone id use to route an alias record to record set"
  value       = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}