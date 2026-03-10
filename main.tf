module "vpc" {
  source = "./modules/vpc"

  vpc_name         = "photoshare-vpc"
  subnet_list      = var.subnet_list
  igw_name         = "photoshare-igw"
  route_table_name = "public-rt"
}

module "iam" {
  source = "./modules/iam"

  ec2_iam = "iam_role_ec2"
  lambda_iam = "iam_role_lambda"
}

module "rds" {
  source = "./modules/rds"

  db_config = {
    name           = "photoshare",
    identifier     = "photoshare-db",
    engine_version = "8.4.7",
    instance_type  = "db.t3.micro",
    storage        = 20,
    storage_type   = "gp3",
    param_group_name = "default.mysql8.4"
  }

  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  vpc_cidr_block     = module.vpc.vpc_cidr_block

  db_username = var.db_username
  db_password = var.db_password

  subnet_group_name = "photoshare-db-group"

  rds_sg_name = "db-sg"
}

module "secretmanager" {
  source = "./modules/secretmanager"

  sm_name = "photoshare/db/credentials"

  sm_config = {
    engine = "mysql",
    host = module.rds_db_address,
    port = 3306,
    dbname = module.rds.rds_db_initial
  }

  db_username = var.db_username
  db_password = var.db_password
}

module "s3" {
  source = "./modules/s3"

  bucket_name = "photoshare-assets-bucket"
}

module "alb"{
  source = "./modules/alb"

  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  instance_id = module.ec2.instance_id
}

module "ec2" {
  source = "./modules/ec2"

  s3_bucket_name = module.s3.s3_bucket_name
  sm_name = module.secretmanager.sm_name
  ec2_role = module.iam.ec2_role
  alb_sg_id = module.alb.alb_sg_id
  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids
}

module "lambda" {
  source = "./modules/lambda"

  s3_bucket_name = module.s3.s3_bucket_name
  function_name = "photoshare-metadata-extractor"
  s3_bucket_id = module.s3.s3_bucket_id
  s3_bucket_arn = module.s3.s3_bucket_arn
  lb_dns_name = module.alb.alb_dns_name
  lambda_role = module.iam.lambda_role
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  dashboard_name = "PhotoShare-Monitor"
  lambda_alarm_name = "PhotoShare-Lambda-Error-Alarm"

  instance_id = module.ec2.instance_id
  lambda_function_name = module.lambda.lambda_function_name
}