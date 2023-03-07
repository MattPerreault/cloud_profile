output "function_name" {
  description = "Name of lambda function"

  value = aws_lambda_function.site_counter.function_name
}