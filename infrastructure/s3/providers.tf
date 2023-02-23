provider "aws" {
  profile                  = "default"
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}