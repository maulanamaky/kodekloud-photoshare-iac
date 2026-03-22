resource "aws_security_group" "photoshare_alb_securitygroup" {
  name        = var.alb_securitygroup_name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.alb_securitygroup_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "photoshare_alb_securitygroup_allow_http" {
  security_group_id = aws_security_group.photoshare_alb_securitygroup.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "photoshare_alb_securitygroup_allow_https" {
  security_group_id = aws_security_group.photoshare_alb_securitygroup.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "photoshare_alb_securitygroup_allow_outbound" {
  security_group_id = aws_security_group.photoshare_alb_securitygroup.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
