output "route53_domain" {
  value = aws_route53_record.root.fqdn
}

output "cert_arn" {
  value = aws_acm_certificate.cert.arn
}
