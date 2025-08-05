locals {
  module_version = "0.4.0"

  tags = {
    created_by_module : "infrahouse/postfix/aws"
    service : "mta-${data.aws_route53_zone.postfix_zone.name}"
  }
}
