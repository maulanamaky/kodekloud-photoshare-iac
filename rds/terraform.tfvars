db_config = {
  name           = "photoshare",
  identifier     = "photoshare-db",
  engine_version = "8.4.7",
  instance_type  = "db.t3.micro",
  storage        = 20,
  storage_type   = "gp3"
}

KKE_DB_USERNAME = "admin"
KKE_DB_PASSWORD = "admin123!"

// ===== SUBNET GROUP =====

KKE_SUBNET_GROUP_NAME = "photoshare-db-group"


// ===== SECURITY GROUP =====

KKE_SG_RDS = "db-sg"