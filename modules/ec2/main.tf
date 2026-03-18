resource "aws_instance" "photoshare_web" {
  ami           = var.ec2_config.ami
  instance_type = var.ec2_config.type
  subnet_id = var.public_subnet_ids[0]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile.name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  associate_public_ip_address = true
  user_data_replace_on_change = true

  key_name = var.key_name

  tags = {
    Name = var.ec2_config.name
  }

  user_data = templatefile("${path.module}/../../src/user_data.sh", {
    s3_bucket_name = var.s3_bucket_name
    sm_name = var.sm_name
  })

}



resource "aws_iam_instance_profile" "ec2-profile" {
  name = "ec2-role-profile"
  role = var.ec2_role
}