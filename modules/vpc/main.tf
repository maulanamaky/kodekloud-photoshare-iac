resource "aws_vpc" "photoshare_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet" {

  for_each = var.subnet_list

  vpc_id            = aws_vpc.photoshare_vpc.id
  cidr_block        = each.value.cidr
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
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "route_table_association" {

  for_each = { for k, v in var.subnet_list : k => v if v.public == true }

  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.photoshare_vpc.id

  tags = {
    Name = var.igw_name
  }
}