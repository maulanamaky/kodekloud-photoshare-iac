// ===== SUBNET =====

resource "aws_db_subnet_group" "db" {
  name       = var.subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = var.subnet_group_name
  }
}

// ===== RDS =====

resource "aws_db_instance" "rds_mysql" {
  identifier     = var.db_config.identifier
  db_name        = var.db_config.name
  engine         = "mysql"
  engine_version = var.db_config.engine_version
  instance_class = var.db_config.instance_type
  username       = var.db_username
  password       = var.db_password

  multi_az       = false

  backup_retention_period = 0
  storage_type            = var.db_config.storage_type
  allocated_storage       = var.db_config.storage

  db_subnet_group_name    = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible     = false

  parameter_group_name = var.db_config.param_group_name
  skip_final_snapshot  = true

  deletion_protection = false
}