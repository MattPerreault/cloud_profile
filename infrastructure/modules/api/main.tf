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