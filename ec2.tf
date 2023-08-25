
resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.desamist.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # This is open to all, consider restricting
  }
}

resource "aws_instance" "public_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.medium"
  key_name      = "demo1"
  subnet_id     = aws_subnet.subnet-1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "PublicInstance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.medium"
  key_name      = "demo1"
  subnet_id     = aws_subnet.subnet-2.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "PrivateInstance"
  }
}
