variable "alb_config"{
    type = map(string)
    default = {
        TG_NAME = "photoshare-tg",
        ALB_NAME = "photoshare-alb"
    }
}

variabel "KKE_SG_ALB_NAME"{
    type = string
    default = "photoshare-sg"
}