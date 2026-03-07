resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg_name
  description = "Security Group for Web Server"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.ec2_sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ec2_sg.id
  referenced_security_group_id = var.alb_sg_id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}