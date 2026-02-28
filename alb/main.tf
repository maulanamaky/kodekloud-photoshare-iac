resource "aws_lb" "photoshare_alb" {
  name               = var.alb_config.ALB_NAME
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.photoshare_sg.id]
  subnets            = [for k, v in aws_subnet.subnet : v.id if var.KKE_SUBNET[k].public == true]
  ip_address_type = "ipv4"

  enable_deletion_protection = true

  tags = {
    Name = var.alb_config.ALB_NAME
  }
}


resource "aws_lb_target_group" "photoshare_tg" {
  name     = var.alb_config.TG_NAME
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.photoshare_vpc.id
}
