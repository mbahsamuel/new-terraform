variable "region" {
  type = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_tag" {
  type = string
  default = "Prod"
}

variable "public_SN_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "pubsn_az" {
  type = string
  default = "us-east-1a"
}

variable "pub_sn_tag" {
  type = string
  default = "pub-sn"
}

variable "privt_SNcidr" {
  type = string
  default = "10.0.2.0/24"
}

variable "prvtsn_az" {
  type = string
  default = "us-east-1b"
}

variable "prvt_sn_tag" {
  type = string
  default = "private"
}


variable "igw_tag" {
  type = string
  default = "prod-IGW"
}

variable "pub_rt" {
  type = string
  default = "public-rt"
}

variable "public_sg" {
  type = string
  default = "desamist-public-sg"
}

variable "private_sg" {
  type = string
  default = "desamist-private-sg"
}

variable "from_port" {
  type = string
  default = "22"
}

variable "to_port" {
  type = string
  default = "22"
}

variable "protocol" {
  type = string
  default = "tcp"
}

# variable "private_inbound" {
#   type = string
#   default = "10.0.1.0/24"
# }

variable "ami" {
  type = string
  default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "demo1"
}

variable "public_ip" {
  type = string
  default = "true"
}

variable "pub_instanceTag" {
  type = string
  default = "PublicInstance"
}

variable "privateTag" {
  type = string
  default = "PrivateInstance"
}




