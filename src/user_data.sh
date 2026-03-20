#!/bin/bash
sudo dnf install -y docker git
sudo systemctl enable --now docker
sudo usermod -aG docker ec2-user

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir -p /home/ec2-user/app
cd /home/ec2-user/app

cat <<EOF > docker-compose.yml
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
EOF

cat <<-EOT > .env
S3_BUCKET=${s3_bucket_name}
AWS_SECRET_NAME=${sm_name}
EOT

sleep 15
sudo /usr/local/bin/docker-compose up -d
