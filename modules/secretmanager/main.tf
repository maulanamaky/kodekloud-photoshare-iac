resource "aws_secretsmanager_secret" "photoshare_sm" {
  name = var.sm_name
  description = "Database Credentials for PhotoSharing App"

  recovery_window_in_days = var.recovery_window
}

resource "aws_secretsmanager_secret_version" "sm_version" {
  secret_id     = aws_secretsmanager_secret.photoshare_sm.id
  secret_string = jsonencode({

    username = var.db_username
    password = var.db_password

    engine = var.sm_config.engine
    host = var.sm_config.host
    port = var.sm_config.port
    dbname = var.sm_config.dbname
  })
}
