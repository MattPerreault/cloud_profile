resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "allow_public_read_access" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.allow_public_read_access.json
}

data "aws_iam_policy_document" "allow_public_read_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

resource "aws_s3_object" "html" {
  for_each = fileset("../../../frontend/public/", "**/*.html")

  bucket = aws_s3_bucket.bucket.bucket
  key    = each.value

  source       = "../../../frontend/public/${each.value}"
  content_type = "text/html"

  # Unless the bucket has encryption enabled, the ETag of each object is an
  # MD5 hash of that object.
  etag = filemd5("../../../frontend/public/${each.value}")
}

output "fileset-results" {
  value = fileset("../../frontend/public/", "**/*")
}