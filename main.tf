
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr   #"10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "${var.vpc_tag}" #prod
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_SN_cidr  #"10.0.1.0/24"
  availability_zone = var.pubsn_az  # "us-east-1a" # Change this to your desired AZ
   tags = {
    Name =  "${var.pub_sn_tag}"  #"${var.tag}"  #"prod"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.privt_SNcidr   #"10.0.2.0/24"
  availability_zone = var.prvtsn_az  #"us-east-1b" # Change this to your desired AZ
   tags = {
    Name = "${var.prvt_sn_tag}"  #"public"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
   tags = {
    Name = "${var.igw_tag}"   #"prod-IGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
 tags = {
    Name = "${var.pub_rt}"  # public
  }
}

resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}



