resource "aws_lb" "photoshare_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.photoshare_alb_securitygroup.id]
  subnets            = var.public_subnet_ids
  ip_address_type = "ipv4"

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "photoshare_alb_targetgroup" {
  name     = var.targetgroup_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "photoshare_alb_listener" {
  load_balancer_arn = aws_lb.photoshare_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.photoshare_alb_targetgroup.arn
  }
}
