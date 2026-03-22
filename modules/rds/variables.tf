variable "database_name"{
  type = string
}

variable "identifier"{
  type = string
}

variable "engine"{
  type = string
}

variable "engine_version"{
  type = string
}

variable "instance_type"{
  type = string
}

variable "storage"{
  type = number
}

variable "storage_type"{
  type = string
}

variable "parameter_group_name"{
  type = string
}

variable "database_username"{
  type = string
}

variable "database_password"{
  type = string
}

// ==== SUBNET GROUP ====

variable "subnet_group_name" {
  type = string
}

variable "rds_securitygroup_name" {
  type = string
}

variable "private_subnet_ids"{
  type = list(string)
}

variable "vpc_id"{
  type = string
}

variable "cidr_block"{
  type = string
}