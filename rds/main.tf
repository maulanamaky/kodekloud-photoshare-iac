// ===== SUBNET =====

resource "aws_db_subnet_group" "db" {
  name       = var.KKE_SUBNET_GROUP_NAME
  subnet_ids = [for k, v in aws_subnet.subnet : v.id if var.KKE_SUBNET[k].public == false]

  tags = {
    Name = var.KKE_SUBNET_GROUP_NAME
  }
}

// ===== RDS =====

resource "aws_db_instance" "rds_mysql" {
  identifier     = var.db_config.identifier
  db_name        = var.db_config.name
  engine         = "mysql"
  engine_version = var.db_config.engine_version
  instance_class = var.db_config.instance_type
  username       = var.KKE_DB_USERNAME
  password       = var.KKE_DB_PASSWORD
  multi_az       = false

  backup_retention_backup = 0
  storage_type            = var.db_config.storage_type
  allocated_storage       = var.db_config.storage

  db_subnet_group_name    = aws_db_subnet_group.db.name
  vpc_security_groups_ids = [aws_security_group.db_sg.id]
  publicly_accessible     = false

  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  deletion_protection = false
}