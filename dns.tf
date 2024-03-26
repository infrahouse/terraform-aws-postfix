resource "aws_route53_record" "postfix_cname" {
  name    = "${var.route53_hostname}.${data.aws_route53_zone.postfix_zone.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.postfix_zone.zone_id
  ttl     = 300
  records = [
    aws_lb.postfix.dns_name
  ]
}
