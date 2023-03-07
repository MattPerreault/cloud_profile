output "s3_origin_arn" {
  description = "ARN of the bucket"
  value       = module.s3_origin.arn
}

output "s3_origin_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.s3_origin.name
}

output "s3_origin_domain" {
  description = "Domain name of the bucket"
  value       = module.s3_origin.domain
}

output "cloudfront_arn" {
  description = "ARN of the cloudfront distribution"
  value       = module.cloudfront_distribution.arn
}

output "cloudfront_domain" {
  description = "Doman name of the cloudfront distribution"
  value       = module.cloudfront_distribution.domain

}

output "route53_domain" {
  description = "Domain of the route53 record"
  value       = module.route53.route53_domain
}

output "lambda_name" {
  description = "Name of the lambda function"
  value       = module.api.function_name
}