variable "alb_config"{
    type = map(string)
    default = {
        tg_name = "photoshare-tg",
        alb_name = "photoshare-alb"
    }
}

variabel "alb_sg_name"{
    type = string
    default = "photoshare-sg"
}

variabel "vpc_id" {
    type = string
}

variabel "public_subnet_ids" {
    type = list(string)
}

variabel "instance_id" {
    type = string
}