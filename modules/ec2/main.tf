resource "aws_instance" "photoshare_web" {
  ami           = var.ec2_config.ami
  instance_type = var.ec2_config.type

  subnet_id = var.public_subnet_ids

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.ec2_config.name
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install -y docker git
              sudo systemctl enable --now docker
              sudo usermod -aG docker ec2-user

              sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose

              cat <<EOT > docker-compose.yml
              services:
                api:
                  image: kodekloud/photosharing-app
                  container_name: photosharing-app
                  ports:
                  - "80:8000"
                  env_file:
                  - .env
                  restart: always
                  healthcheck:
                    test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
                    interval: 30s
                    timeout: 10s
                    retries: 3
                    start_period: 40s
              EOT

              cat <<-EOT > .env
              S3_BUCKET=${var.s3_bucket_name}
              AWS_SECRET_NAME=${var.sm_name}
              EOT

              sudo /usr/local/bin/docker-compose up -d
  EOF

}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-role-profile"
  role = var.ec2_role
}