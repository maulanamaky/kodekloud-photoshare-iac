variable "type"{
    type = string
    default = "t3.micro"
}

variable "ami"{
    type = string
    default = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

variable "instance_name"{
    type = string
}

variable "bucket_name"{
    type = string
}

variable "secrets_name"{
    type = string
}

variable "ec2_iam_role"{
    type = string
}

// === Networking ===

variable "vpc_id"{
    type = string
}

variable "public_subnet_ids"{
    type = list(string)
}

// === Security Group ===

variable "ec2_securitygroup_name"{
    type = string
}

variable "alb_securitygroup_id"{
    type = string
}

// === Key Pair EC2 ===

variable "key_pair_name"{
    type = string
    description = "Name of the key EC2"
}

variable "pub_key"{
  type = string
  default = "Paste the public code here"
  sensitive = true
}