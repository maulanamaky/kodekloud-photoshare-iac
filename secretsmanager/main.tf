data "aws_kms_alias" "secretsmanager" {
  name = "alias/aws/secretsmanager"
}

resource "aws_secretsmanager_secret" "photoshare_sm" {
  name = var.sm_config
  description = "Database Credentials for PhotoSharing App"

  kms_key_id = data.aws_kms_alias.secretsmanager.arn
}

resource "aws_secretsmanager_secret_version" "sm_version" {
  secret_id     = aws_secretsmanager_secret.photoshare_sm.id
  secret_string = jsonencode({
    username = var.KKE_DB_USERNAME
    password = var.KKE_DB_PASSWORD
    engine = "mysql"
    host = aws_db_instance.rds_mysql.address
    port = "3306"
    dbname = var.db_config.name
  })
}