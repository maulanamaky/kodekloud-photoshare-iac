variable "vpc_name" {
  type = string
}

variable "subnet_lists" {
  type = map(object({
    cidr = string
    region = string
    public = bool
  }))
}

variable "igw_name" {
  type    = string
}

variable "route_table_name" {
  type    = string
}