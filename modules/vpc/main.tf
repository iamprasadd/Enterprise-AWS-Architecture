resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.name}-nat"
  }
}

resource "aws_eip" "nat" {
  
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private_app" {
  count = length(var.private_app_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_app_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.name}-private-app-${count.index + 1}"
  }
}

resource "aws_subnet" "private_db" {
  count = length(var.private_db_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_db_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.name}-private-db-${count.index + 1}"
  }
}
