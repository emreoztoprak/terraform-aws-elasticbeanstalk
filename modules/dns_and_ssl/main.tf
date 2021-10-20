data "aws_route53_zone" "public" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_acm_certificate" "myapp" {
  domain_name       = "${var.domain_name}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_type
  zone_id  = data.aws_route53_zone.public.id
  ttl      = 60
}


resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.myapp.arn
  validation_record_fqdns = [ aws_route53_record.cert_validation.fqdn ]
}

resource "aws_route53_record" "myapp" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = "${var.domain_name}"
  type    = "A"
  alias {
    name                   = var.cname
    zone_id                = var.zone
    evaluate_target_health = false
  }
}