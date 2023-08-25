# # creating a provider with aws 
# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# provider "aws" {
#   region     = "us-east-1"
# #   access_key = "my-access-key"
# #   secret_key = "my-secret-key"
# }


# creating a vpc 
# https://registry.terraform.io/providers/hashicorp/aws/2.36.0/docs/resources/vpc
resource "aws_vpc" "desamist" {
    cidr_block = "10.0.0.0/16" # for manuall typing do control + spacebar
    instance_tenancy = "dedicated"
     tags = {
    Name = "dev"
  }
}

#create an IGW

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.desamist.id

  tags = {
    Name = "dev"
  }
}

# creation of subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.desamist.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "dev"
  }
}

#creating a second subnet

resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.desamist.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "dev"
  }
}

# 3. Create Custom Route Table to route tratic to internet

resource "aws_route_table" "dev-route-table-1" {
  vpc_id = aws_vpc.desamist.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "dev"
  }
}



resource "aws_route_table" "dev-route-table-2" {
  vpc_id = aws_vpc.desamist.id
  tags = {
    Name = "dev"
  }
}

# route table association
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

resource "aws_route_table_association" "subnet-1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.dev-route-table-1.id
}

resource "aws_route_table_association" "subnet-2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.dev-route-table-2.id
}

