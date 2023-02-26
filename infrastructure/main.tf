module "s3_origin" {
  source      = "./modules/s3"
  bucket_name = "mpcloudstack.com"
}

module "cloudfront_distribution" {
  source      = "./modules/cloudfront"
  domain      = module.s3_origin.domain
  domain_name = module.s3_origin.name
}

module "route53" {
  source                       = "./modules/route53"
  domain                       = module.s3_origin.name
  cf_distribution_domain       = module.cloudfront_distribution.domain
  cf_distribution_host_zone_id = module.cloudfront_distribution.hosted_zone
}
