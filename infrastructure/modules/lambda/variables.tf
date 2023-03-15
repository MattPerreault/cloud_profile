variable "source_dir" {
  description = "Path to lambda archive directory"
  type        = string
}

variable "output_path_get_lambda" {
  description = "Path to .zip output file for get lambda"
  type        = string
}

variable "output_path_put_lambda" {
  description = "Path to .zip output file for put lambda"
  type        = string
}

variable "dynamo_arn" {
  description = "ARN for dynamodb used for policy"
  type        = string
}