variable "source_dir" {
  description = "Path to lambda archive directory"
  type        = string
}

variable "output_path" {
  description = "Path to .zip output file"
  type        = string
}

variable "dynamo_arn" {
  description = "ARN for dynamodb used for policy"
  type        = string
}