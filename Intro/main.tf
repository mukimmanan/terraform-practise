provider "aws" {
    region = var.aws_region
}

data "aws_availability_zone" "available" {

}

data "aws_region" "current" {

}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    "Name" = var.vpc_name
    "Terraform" = "true"
    "Enviromnment" = "Demo"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnets
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zone.available.name)[each.value]

  tags = {
    Name = each.key
    Terraform = "true"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zone.available.name)[each.value]

  tags = {
    Name = each.key
    Terraform = "true"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "demo_public_rtb"
    Terraform = true
  }
}

resource "aws_route_table" "private_route_touble" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "demo_private_rtb"
    Terraform = true
  }
}

resource "aws_route_table_association" "public" {
  depends_on = [
    aws_subnet.public_subnets
  ]
  route_table_id = aws_route_table.public_route_table.id
  for_each = aws_subnet.public_subnets
  subnet_id = each.value.id
}

resource "aws_route_table_association" "private" {
  depends_on = [
    aws_subnet.private_subnets
  ]
  route_table_id = aws_route_table.private_route_touble.id
  for_each = aws_subnet.private_subnets
  subnet_id = each.value.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
    Terraform = "true"
  }
}

resource "aws_eip" "eip" {
  vpc = true
  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_nat_gateway" "nat_gateway" {
  depends_on = [
    aws_subnet.public_subnets
  ]
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnets["public_subet_1"].id
  tags = {
    Name = "Nat Gateway"
  }
}