output "vpc_id"{
    value = aws_vpc.photoshare_vpc.id
}

output "private_subnet_ids"{
    value = [for k, v in aws_subnet.subnet : v.id if var.subnet_list[k].public == false]
}

output "private_subnet_ids"{
    value = [for k, v in aws_subnet.subnet : v.id if var.subnet_list[k].public == true]
}

output "vpc_cidr_block" {
    value = aws_vpc.photoshare_vpc.cidr_block
}