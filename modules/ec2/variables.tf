variable "ec2_config"{
    type = map(string)
    default = {
        type = "t3.micro",
        ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64",
        name = "photoshare-web"
    }
}

variable "ec2_sg_name"{
    type = string
    default = "photoshare-web-sg"
}

variable "key_pair_name"{
    type = string
}

variable "pub_key"{
  type = string
  default = "Paste the public code here"
}

variable "public_subnet_ids"{
    type = list(string)
}

variable "s3_bucket_name"{
    type = string
}

variable "sm_name"{
    type = string
}

variable "ec2_role"{
    type = string
}

variable "alb_sg_id"{
    type = string
}

variable "vpc_id"{
    type = string
}
