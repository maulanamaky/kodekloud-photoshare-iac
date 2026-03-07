resource "aws_security_group" "db_sg" {
  name        = var.rds_sg_name
  description = "Security Group for Photoshare RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.rds_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = var.vpc_cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}