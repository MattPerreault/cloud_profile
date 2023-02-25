output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.bucket.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.bucket.id
}

output "domain" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket_website_configuration.s3_website.website_domain
}
