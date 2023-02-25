module "s3_website" {
  source      = "./modules/s3"
  bucket_name = "mattscloudstack.com"
}