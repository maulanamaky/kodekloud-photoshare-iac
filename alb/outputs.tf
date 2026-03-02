output "alb_dns_endpoint" {
    value = "http://${aws_lb.photoshare_alb.dns_name}"
    description = "Akses dengan URL berikut dan di port 80"
}