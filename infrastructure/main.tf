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

module "api" {
  source      = "./modules/api"
  source_dir  = "${path.module}/../backend/"
  output_path = "${path.module}/../backend/lambda_handler.zip"
}
