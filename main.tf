module "vpc" {
  source = "./modules/vpc"

  vpc_name         = "photoshare-vpc"
  subnet_lists      = var.subnet_lists
  igw_name         = "photoshare-igw"
  route_table_name = "public-rt"
}

module "iam" {
  source = "./modules/iam"

  ec2_iam_role_name = "iam_role_ec2"
  lambda_iam_role_name = "iam_role_lambda"
}

module "rds" {
  source = "./modules/rds"

  database_name = "photoshare"
  identifier = "photoshare-db"
  engine = "mysql"
  engine_version = "8.4.7"
  instance_type = "db.t3.micro"
  storage = 20
  storage_type = "gp3"
  parameter_group_name = "default.mysql8.4"

  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  cidr_block     = module.vpc.cidr_block

  database_username = var.database_username
  database_password = var.database_password

  subnet_group_name = "photoshare-db-group"

  rds_securitygroup_name = "db-sg"
}

module "secretsmanager" {
  source = "./modules/secretsmanager"

  secrets_name = "photoshare/db/credentials"
  recovery_window_in_days = 0

  database_engine = "mysql"
  database_host = module.rds.database_address
  database_port = 3306
  database_name = module.rds.database_initial

  database_username = var.database_username
  database_password = var.database_password
}

module "s3" {
  source = "./modules/s3"

  bucket_name = "photoshare-assets-bucket"
}

module "alb"{
  source = "./modules/alb"

  alb_name = "photoshare-sg"
  targetgroup_name = "photoshare-sg"
  alb_securitygroup_name = "photoshare-sg"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ec2_instance_id = module.ec2.instance_id
}

module "ec2" {
  source = "./modules/ec2"

  type = "t3.micro"
  instance_name = "photoshare-instance"

  bucket_name = module.s3.bucket_name
  secrets_name = module.secretsmanager.secretsmanager_name
  ec2_iam_role = module.iam.ec2_iam_role
  
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

  pub_key = var.pub_key
  key_pair_name = var.key_pair_name

  ec2_securitygroup_name = "photoshare-web-sg"
  alb_securitygroup_id = module.alb.alb_securitygroup_id
}

module "lambda" {
  source = "./modules/lambda"

  function_name = "photoshare-metadata-extractor"
  lambda_iam_role = module.iam.lambda_iam_role

  bucket_name = module.s3.bucket_name
  bucket_id = module.s3.bucket_id
  bucket_arn = module.s3.bucket_arn

  lb_dns_name = module.alb.alb_dns_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  dashboard_name = "PhotoShare-Monitor"

  ec2_instance_id = module.ec2.instance_id
  lambda_function_name = module.lambda.lambda_function_name
  lambda_alarm_name = "PhotoShare-Lambda-Error-Alarm"
}
