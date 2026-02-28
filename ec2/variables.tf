variable "ec2_config"{
    type = map(string)
    default = {
        type = "t3.micro",
        ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64",
        name = "photoshare-web"
    }
}

variable "KKE_SG_EC2_NAME"{
    type = string
    default = "photoshare-web-sg"
}