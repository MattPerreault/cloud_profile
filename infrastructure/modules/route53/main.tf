data "aws_route53_zone" "primary" {
  name         = var.domain
  private_zone = false
}

# Create ACM SSL Cert
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# DNS record for ACM cert validation to prove we own domain
resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.primary.id
  ttl             = 60

}

# Cert validation for the record
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

# DNS record for mpcloudstack.com to point to cloudfront distribution
resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.primary.id
  name    = var.domain
  type    = "A"

  alias {
    name                   = var.cf_distribution_domain
    zone_id                = var.cf_distribution_host_zone_id
    evaluate_target_health = false
  }
}
