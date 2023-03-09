output "dynamo_arn" {
  description = "ARN of the dynamodb table"
  value       = aws_dynamodb_table.site_stats.arn
}