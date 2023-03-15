output "get_function_name" {
  description = "Name of get lambda function"

  value = aws_lambda_function.get_site_counter.function_name
}

output "get_function_arn" {
  description = "ARN of the get lambda"

  value = aws_lambda_function.get_site_counter.invoke_arn
}

output "put_function_name" {
  description = "Name of put lambda function"

  value = aws_lambda_function.update_site_counter.function_name
}

output "put_function_arn" {
  description = "ARN of the put lambda"

  value = aws_lambda_function.update_site_counter.invoke_arn
}
