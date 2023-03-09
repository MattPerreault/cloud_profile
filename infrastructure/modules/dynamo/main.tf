resource "aws_dynamodb_table" "site_stats" {
  name         = "site_stats"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "stat"

  attribute {
    name = "stat"
    type = "S"
  }
}
