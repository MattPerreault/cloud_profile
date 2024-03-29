data "archive_file" "lambda_get_handler" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = var.output_path_get_lambda
}

data "archive_file" "lambda_put_handler" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = var.output_path_put_lambda
}

resource "aws_s3_bucket" "mpcloudstack_lambda_bucket" {
  bucket = "mpcloudstack-lambda-bucket"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.mpcloudstack_lambda_bucket.id
  acl    = "private"
}

resource "aws_s3_object" "lambda_get_handler" {
  bucket = aws_s3_bucket.mpcloudstack_lambda_bucket.id

  key    = "lambda_get_handler.zip"
  source = data.archive_file.lambda_get_handler.output_path
  etag   = filemd5(data.archive_file.lambda_get_handler.output_path)
}

resource "aws_s3_object" "lambda_put_handler" {
  bucket = aws_s3_bucket.mpcloudstack_lambda_bucket.id

  key    = "lambda_put_handler.zip"
  source = data.archive_file.lambda_put_handler.output_path
  etag   = filemd5(data.archive_file.lambda_put_handler.output_path)
}

resource "aws_lambda_function" "get_site_counter" {
  function_name = "get_site_counter"

  s3_bucket = aws_s3_bucket.mpcloudstack_lambda_bucket.id
  s3_key    = aws_s3_object.lambda_get_handler.key

  runtime = "python3.9"
  handler = "lambda_get_handler.lambda_get_handler"

  source_code_hash = data.archive_file.lambda_get_handler.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_lambda_function" "update_site_counter" {
  function_name = "update_site_counter"

  s3_bucket = aws_s3_bucket.mpcloudstack_lambda_bucket.id
  s3_key    = aws_s3_object.lambda_put_handler.key

  runtime = "python3.9"
  handler = "lambda_put_handler.lambda_put_handler"

  source_code_hash = data.archive_file.lambda_put_handler.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "get_site_counter_log_group" {
  name = "/aws/lambda/${aws_lambda_function.get_site_counter.function_name}"

  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "update_site_counter_log_group" {
  name = "/aws/lambda/${aws_lambda_function.update_site_counter.function_name}"

  retention_in_days = 1
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "dynamo_access_policy" {
  name = "dynamo_access_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:UpdateItem"
        ]
        Resource = [
          var.dynamo_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "dynamo_policy_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.dynamo_access_policy.arn
}
