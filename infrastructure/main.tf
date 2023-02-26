module "s3_origin" {
  source      = "./modules/s3"
  bucket_name = "mattscloudstack.com"
}

module "cloudfront_distribution" {
  source = "./modules/cloudfront"
  domain = module.s3_origin.domain
}
