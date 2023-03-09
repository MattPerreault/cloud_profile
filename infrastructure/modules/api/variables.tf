variable "region" {
  type        = string
  description = "Region the API Gateway is in"
}

variable "account_id" {
  type        = string
  description = "Account ID API Gateway belongs to"
}

variable "rest_api_name" {
  type        = string
  description = "Name of the API Gateway created"
  default     = "profile-views-api"
}

variable "rest_api_stage_name" {
  type        = string
  description = "The name of the API Gateway stage"
  default     = "prod"
}

variable "lambda_get_handler" {
  type        = string
  description = "The name of the API GET lambda function"
}

variable "lambda_get_handler_arn" {
  type        = string
  description = "The ARN of the API GET lambda function"
}
