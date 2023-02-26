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
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
}
