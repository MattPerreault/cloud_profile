module "s3_origin" {
  source      = "./modules/s3"
  bucket_name = "mpcloudstack.com"
}

module "cloudfront_distribution" {
  source      = "./modules/cloudfront"
  domain      = module.s3_origin.domain
  domain_name = "mpcloudstack.com"
  cert_arn    = module.route53.cert_arn
}

module "route53" {
  source                       = "./modules/route53"
  domain                       = "mpcloudstack.com"
  cf_distribution_domain       = module.cloudfront_distribution.domain
  cf_distribution_host_zone_id = module.cloudfront_distribution.hosted_zone
}

module "lambda" {
  source      = "./modules/lambda"
  source_dir  = "${path.module}/../backend/"
  output_path = "${path.module}/../backend/lambda_handler.zip"
}

data "aws_caller_identity" "current" {}

module "api" {
  source                 = "./modules/api"
  region                 = "us-east-1"
  account_id             = data.aws_caller_identity.current.account_id
  lambda_get_handler     = module.lambda.function_name
  lambda_get_handler_arn = module.lambda.function_arn
  depends_on = [
    module.lambda.function
  ]
}
