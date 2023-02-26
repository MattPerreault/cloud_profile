resource "aws_route53_zone" "primary" {
  name = var.domain
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.primary.id
  name = var.domain
  type = "A"

  alias {
    name = var.cf_distribution_domain
    zone_id = var.cf_distribution_host_zone_id
    evaluate_target_health = false
  }
}
