
resource "aws_security_group" "public_sg" {
  name_prefix = "public-"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "${var.public_sg}"  # desamist-public-sg
  }
}

resource "aws_security_group" "private_sg" {
  name_prefix = "private-"
  vpc_id      = aws_vpc.my_vpc.id
   tags = {
    Name = "${var.private_sg}"  # desamist-private-sg
  }
}

resource "aws_security_group_rule" "public_inbound_http" {
  type        = "ingress"
  from_port   = var.from_port #22
  to_port     = var.to_port #22
  protocol    = var.protocol #"tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

resource "aws_security_group_rule" "private_inbound_ssh" {
  type        = "ingress"
  from_port   = var.from_port #22
  to_port     = var.to_port #22
  protocol    = var.protocol #"tcp"
  cidr_blocks = ["10.0.1.0/24"] # Allowing SSH only from the public subnet
  security_group_id = aws_security_group.private_sg.id
}

resource "aws_instance" "ec2_instance_1" {
  ami           = var.ami   #"ami-053b0d53c279acc90" # Use a valid AMI ID
  instance_type = var.instance_type   #"t2.micro"
  key_name      = var.key_name  # "demo1"
  subnet_id     = aws_subnet.public_subnet.id
  associate_public_ip_address = var.public_ip #true
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  tags = {
    Name = "${var.pub_instanceTag}"  #"PublicInstance"
  }
}

resource "aws_instance" "ec2_instance_2" {
  ami           = var.ami  #"ami-053b0d53c279acc90" # Use a valid AMI ID
  instance_type = var.instance_type  #"t2.micro"
  key_name      = var.key_name   #"demo1"
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = {
    Name = "${var.privateTag}"  # "PrivateInstance"
  }
}