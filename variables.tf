variable "host_os" {
  default = "linux"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "availability_zone" {
  default = "us-west-1a"
}

variable "destination_cidr_block" {
  default = "0.0.0.0/0"
}

variable "owners" {
  default = "099720109477"
}

variable "values" {
  default = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
}

variable "vpc_cidr" {
  default = "10.123.0.0/16"
}

variable "subnet_cidr" {
  default = "10.123.1.0/24"
}

variable "sg_ingress_cidr" {
  default = "37.0.0.0/8"
}

variable "sg_egress_cidr" {
  default = "0.0.0.0/0"
}

variable "vpc_tags" {
  default = {
    name = "dev"
  }
}

variable "subnet_tags" {
  default = {
    name = "dev-public"
  }
}

variable "internet_gateway_tags" {
  default = {
    name = "dev-igw"
  }
}

variable "route_table_tags" {
  default = {
    name = "dev-public-rt"
  }
}

variable "sg_name" {
  default = "dev_sg"
}

variable "instance_tags" {
  default = {
    name = "dev-node"
  }
}