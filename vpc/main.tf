resource "aws_vpc" "photoshare_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.KKE_VPC_NAME
  }
}

resource "aws_subnet" "subnet" {

  for_each = var.KKE_SUBNET

  vpc_id     = aws_vpc.photoshare_vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.region

  map_public_ip_on_launch = each.value.public

  tags = {
    Name = each.key
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.photoshare_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.KKE_ROUTE_TABLE_NAME
  }
}

resource "aws_route_table_association" "route_table_association" {

  for_each = { for k, v in var.KKE_SUBNET : k => v if v.public == true }

  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.photoshare_vpc.id

  tags = {
    Name = var.KKE_IGW_NAME
  }
}