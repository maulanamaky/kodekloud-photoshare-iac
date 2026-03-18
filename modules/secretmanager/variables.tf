variable "sm_name"{
    type = string
    description = "Name of the secret"
}

variable "recovery_window"{
  type = number
  description = "The input is number for long keep credentials"
}

variable "sm_config"{
    type = object({
        engine = string
        host = string
        port = number
        dbname = string
    })
}

variable "db_username"{
    type = string
    description = "Database Username"
    sensitive = true
}

variable "db_password"{
    type = string
    description = "Database Password"
    sensitive = true
}
