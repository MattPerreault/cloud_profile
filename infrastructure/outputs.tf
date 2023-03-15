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

output "lambda_get_name" {
  description = "Name of the lambda get function"
  value       = module.lambda.get_function_name
}

output "lambda_put_name" {
  description = "Name of the lambda put function"
  value       = module.lambda.put_function_name
}

output "rest_api_url" {
  description = "URL of the API"
  value       = module.api.rest_api_url
}

output "dynamo_db_arn" {
  description = "ARN of dynamo db table"
  value       = module.dynamo.dynamo_arn
}
