resource "aws_security_group" "postfix" {
  vpc_id      = data.aws_subnet.selected.vpc_id
  name_prefix = "postfix"
  description = "Manage traffic to postfix"
  tags = merge(
    {
      Name : "postfix"
    },
    local.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  description       = "Allow SSH traffic"
  security_group_id = aws_security_group.postfix.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = data.aws_vpc.selected.cidr_block
  tags = merge({
    Name = "SSH access"
    },
    local.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "smtp" {
  description       = "Allow SMTP traffic"
  security_group_id = aws_security_group.postfix.id
  from_port         = 25
  to_port           = 25
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  tags = merge({
    Name = "SMTP access"
    },
    local.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  description       = "Allow all ICMP traffic"
  security_group_id = aws_security_group.postfix.id
  from_port         = -1
  to_port           = -1
  ip_protocol       = "icmp"
  cidr_ipv4         = "0.0.0.0/0"
  tags = merge({
    Name = "ICMP traffic"
    },
    local.tags
  )
}

resource "aws_vpc_security_group_egress_rule" "default" {
  description       = "Allow all traffic"
  security_group_id = aws_security_group.postfix.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  tags = merge(
    {
      Name = "outgoing traffic"
    },
    local.tags
  )
}
