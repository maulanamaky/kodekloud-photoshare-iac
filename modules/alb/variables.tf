variable "targetgroup_name"{
    type = string
}

variable "alb_name"{
    type = string
}

variable "alb_securitygroup_name"{
    type = string
}

variable "vpc_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "ec2_instance_id" {
    type = string
}