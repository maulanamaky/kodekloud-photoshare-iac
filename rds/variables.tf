variable "db_config" {
  type = object({
    name           = string,
    identifier     = string,
    engine_version = string,
    instance_type  = "string",
    storage        = number,
    storage_type   = string
  })
}

variable "KKE_DB_USERNAME"{
  type = string
}

variable "KKE_DB_PASSWORD"{
  type = string
}

// ==== SUBNET GROUP ====

variable "KKE_SUBNET_GROUP_NAME" {
  type = string
}
