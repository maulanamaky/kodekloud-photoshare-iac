variable "db_config" {
  type = object({
    name           = string,
    identifier     = string,
    engine_version = string,
    instance_type  = string,
    storage        = number,
    storage_type   = string,
    param_group_name = string
  })
}

variable "db_username"{
  type = string
}

variable "db_password"{
  type = string
}

// ==== SUBNET GROUP ====

variable "subnet_group_name" {
  type = string
}

variable "rds_sg_name" {
  type = string
}

variable "private_subnet_ids"{
  type = list(string)
}

variable "vpc_id"{
  type = string
}

variable "vpc_cidr_block"{
  type = string
}
