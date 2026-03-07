resource "aws_lb" "photoshare_alb" {
  name               = var.alb_config.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.photoshare_alb_sg.id]
  subnets            = var.public_subnet_ids
  ip_address_type = "ipv4"

  enable_deletion_protection = true

  tags = {
    Name = var.alb_config.alb_name
  }
}

resource "aws_lb_target_group" "photoshare_tg" {
  name     = var.alb_config.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "ec2_tg" {
  target_group_arn = aws_lb_target_group.photoshare_tg.arn
  target_id        = var.instance_id        
  port             = 80
}
