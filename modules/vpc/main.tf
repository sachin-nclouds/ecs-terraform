locals {
  customer_name = "mClouds-${var.env}"
}
data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${local.customer_name}-Terraform-vpc"
    ENV  = var.env
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet1_cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.customer_name}-Terraform-subnet-1"
    ENV  = var.env
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet2_cidr
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "${local.customer_name}-Terraform-subnet-2"
    ENV  = var.env
  }
}
resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet3_cidr
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.customer_name}-Terraform-subnet-3"
    ENV  = var.env
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.customer_name}-Terraform-IGW"
    ENV  = var.env
  }
}

resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat_gateway_eip.id 
  subnet_id     = aws_subnet.subnet2.id

  tags = {
    Name = "${local.customer_name}-Terraform-IGW"
    Name = "nat-gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "public-rt-1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${local.customer_name}-Terraform-routetable-pub"
    ENV  = var.env
  }
}

resource "aws_route_table" "pvt-rt-2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "${local.customer_name}-Terraform-routetable-pvt"
    ENV  = var.env
  }
}

resource "aws_route_table_association" "rt1" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public-rt-1.id
}
resource "aws_route_table_association" "rt3" {
  subnet_id = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public-rt-1.id
}

resource "aws_route_table_association" "rt2" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.pvt-rt-2.id
}