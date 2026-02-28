variable "KKE_VPC_NAME" {
  type = string
}

variable "KKE_SUBNET" {
  default = {
    "Public Subnet 1" = {
      cidr   = "10.0.1.0/24",
      region = "us-east-1a",
      public = true
    },
    "Private Subnet 1" = {
      cidr   = "10.0.2.0/24",
      region = "us-east-1a",
      public = false
    },
    "Public Subnet 2" = {
      cidr   = "10.0.3.0/24",
      region = "us-east-1b",
      public = true
    },
    "Private Subnet 2" = {
      cidr   = "10.0.4.0/24",
      region = "us-east-1b",
      public = false
    }
  }
}

variable "KKE_IGW_NAME" {
  type    = string
  default = "photoshare-igw"
}

variable "KKE_ROUTE_TABLE_NAME" {
  type    = string
  default = "public-rt"
}