resource "aws_security_group" "photoshare_rds_securitygroup" {
  name        = var.rds_securitygroup_name
  description = "Security Group for Photoshare RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.rds_securitygroup_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "photoshare_rds_securitygroup_allow_mysql" {
  security_group_id = aws_security_group.photoshare_rds_securitygroup.id
  cidr_ipv4         = var.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}