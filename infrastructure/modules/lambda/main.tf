data "archive_file" "lambda_handler" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = var.output_path
}

resource "aws_s3_bucket" "mpcloudstack_lambda_bucket" {
  bucket = "mpcloudstack-lambda-bucket"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.mpcloudstack_lambda_bucket.id
  acl    = "private"
}

resource "aws_s3_object" "lambda_handler" {
  bucket = aws_s3_bucket.mpcloudstack_lambda_bucket.id

  key    = "lambda_handler.zip"
  source = data.archive_file.lambda_handler.output_path
  etag   = filemd5(data.archive_file.lambda_handler.output_path)
}

resource "aws_lambda_function" "site_counter" {
  function_name = "site_counter"

  s3_bucket = aws_s3_bucket.mpcloudstack_lambda_bucket.id
  s3_key    = aws_s3_object.lambda_handler.key

  runtime = "python3.9"
  handler = "lambda_handler.lambda_handler"

  source_code_hash = data.archive_file.lambda_handler.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "site_counter_log_group" {
  name = "/aws/lambda/${aws_lambda_function.site_counter.function_name}"

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

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
