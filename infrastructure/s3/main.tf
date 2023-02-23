terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "cloud-profile-website"
}