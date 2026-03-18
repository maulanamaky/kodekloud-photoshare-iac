variable "subnet_list" {
  type = map(object({
    cidr   = string
    region = string
    public = bool
  }))
}

// === SECRET MANAGER ===

variable "db_username" {
  type = string
  sensitive = true
}

variable "db_password" {
  type = string
  sensitive = true
}

// === EC2 ===

variable "key_pair_name"{
  type = string
  default = "photoshare-key"
}

variable "pub_key"{
  type = string
  sensitive = true
}
