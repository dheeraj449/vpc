# create vpc
# terraform aws create vpc
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"   # change if needed
}
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "cloud vpc"
  }
}

# create internet gateway and attach it to vpc
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "cloud internet gateway"
  }
}
# create public subnet az1
# terraform aws create subnet
resource "aws_subnet" "public_subnet_az1" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = var.public_subnet_az1_cidr
 availability_zone = "ap-south-1a"
 map_public_ip_on_launch = true
 tags = {
   Name = "public subnet "
 }
}

# create route table and add public route 
# terraform aws create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
tags = {
    Name = "Route table"
  }
}
#associate public subnet az1 to "public route table"
#terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_az1_route_table" {
  subnet_id     = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

# create private app subnet az1
# terraform aws create subnet
resource "aws_subnet" "private_subnet_az1" {
 vpc_id = aws_vpc.vpc.id
 cidr_block = var.private_subnet_az1_cidr
 availability_zone = "ap-south-1a"
 map_public_ip_on_launch = false
 tags = {
   Name = "private subnet"
 }
}
