

resource "aws_vpc" "f5-xc-ext-client" {
  cidr_block           = "192.168.0.0/20"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "${var.projectPrefix}-f5-xc-ext-client"
  }
}

resource "aws_subnet" "f5-xc-ext-client-external" {
  vpc_id                  = aws_vpc.f5-xc-ext-client.id
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.awsRegion}a"

  tags = {
    Name = "${var.projectPrefix}-f5-xc-ext-client-external"
  }
}


resource "aws_internet_gateway" "f5-xc-client-vpc-gw" {
  vpc_id = aws_vpc.f5-xc-ext-client.id
  tags = {
    Name = "${var.projectPrefix}-f5-xc-client-igw"
  }
}

resource "aws_route_table" "f5-xc-client-external-rt" {
  vpc_id = aws_vpc.f5-xc-ext-client.id

  tags = {
    Name = "${var.projectPrefix}-f5-xc-client-external-rt"
  }
}

resource "aws_route" "f5-xc-gateway" {
  route_table_id         = aws_route_table.f5-xc-client-external-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.f5-xc-client-vpc-gw.id
}

resource "aws_route_table_association" "f5-xc-client-1" {
  subnet_id      = aws_subnet.f5-xc-ext-client-external.id
  route_table_id = aws_route_table.f5-xc-client-external-rt.id
}


resource "aws_security_group" "f5-xc-sg" {
  name   = "${var.projectPrefix}-f5-xc-client-sg"
  vpc_id = aws_vpc.f5-xc-ext-client.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["100.64.0.0/12"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.trusted_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

