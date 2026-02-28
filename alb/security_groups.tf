resource "aws_security_group" "photoshare_sg" {
  name        = var.KKE_SG_ALB_NAME
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.photoshare_vpc.id

  tags = {
    Name = var.KKE_SG_ALB_NAME
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.photoshare_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.photoshare_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}