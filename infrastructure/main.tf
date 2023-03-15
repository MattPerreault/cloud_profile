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
  source                 = "./modules/lambda"
  source_dir             = "${path.module}/../backend/"
  output_path_get_lambda = "${path.module}/../backend/lambda_get_handler.zip"
  output_path_put_lambda = "${path.module}/../backend/lambda_put_handler.zip"
  dynamo_arn             = module.dynamo.dynamo_arn
  depends_on = [
    module.dynamo.table
  ]
}

data "aws_caller_identity" "current" {}

module "api" {
  source                 = "./modules/api"
  region                 = "us-east-1"
  account_id             = data.aws_caller_identity.current.account_id
  lambda_get_handler     = module.lambda.get_function_name
  lambda_get_handler_arn = module.lambda.get_function_arn
  lambda_put_handler     = module.lambda.put_function_name
  lambda_put_handler_arn = module.lambda.put_function_arn
  depends_on = [
    module.lambda.function
  ]
}

module "dynamo" {
  source = "./modules/dynamo"
}
