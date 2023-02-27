variable "domain" {
  description = "Domain name for the DNS record"
  type        = string
}

variable "cf_distribution_domain" {
  description = "Domain of the CF distribution"
  type        = string
}

variable "cf_distribution_host_zone_id" {
  description = "Route53 hosted zone id"
  type        = string
}
