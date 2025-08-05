locals {
  name_prefix = substr("postfix", 0, 6)

}
resource "aws_lb" "postfix" {
  name_prefix                      = local.name_prefix
  load_balancer_type               = "network"
  subnets                          = var.nlb_subnet_ids
  enable_cross_zone_load_balancing = true
  security_groups = [
    aws_security_group.postfix.id
  ]
  tags = merge(
    local.tags,
    {
      module_version : local.module_version
    }
  )
}

resource "aws_lb_target_group" "postfix" {
  name_prefix = local.name_prefix
  port        = 25
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.nlb_selected.id
  tags        = local.tags
  stickiness {
    enabled = true
    type    = "source_ip"
  }
}

resource "aws_lb_listener" "postfix" {
  load_balancer_arn = aws_lb.postfix.arn
  port              = 25
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.postfix.arn
  }
}
