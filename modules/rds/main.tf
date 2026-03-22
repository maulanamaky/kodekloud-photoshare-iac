// ===== SUBNET =====

resource "aws_db_subnet_group" "photoshare_subnet_group_database" {
  name       = var.subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = var.subnet_group_name
  }
}

// ===== RDS =====

resource "aws_db_instance" "photoshare_database" {
  identifier     = var.identifier
  db_name        = var.database_name
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_type
  username       = var.database_username
  password       = var.database_password

  multi_az       = false

  backup_retention_period = 0
  storage_type            = var.storage_type
  allocated_storage       = var.storage

  db_subnet_group_name    = aws_db_subnet_group.photoshare_subnet_group_database.name
  vpc_security_group_ids = [aws_security_group.photoshare_rds_securitygroup.id]
  publicly_accessible     = false

  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true

  deletion_protection = false
}