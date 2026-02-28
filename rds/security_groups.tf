resource "aws_security_group" "db_sg" {
  name        = var.KKE_SG_RDS
  description = "Security Group for Photoshare RDS"
  vpc_id      = aws_vpc.photoshare_vpc.id

  tags = {
    Name = var.KKE_SG_RDS
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = aws_vpc.photoshare_vpc.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}