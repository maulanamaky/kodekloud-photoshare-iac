variable "alb_config"{
    type = map(string)
    default = {
        tg_name = "photoshare-tg",
        alb_name = "photoshare-alb"
    }
}

variable "alb_sg_name"{
    type = string
    default = "photoshare-sg"
}

variable "vpc_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "instance_id" {
    type = string
}