resource "aws_vpc" "mtc_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.vpc_tags
}

resource "aws_subnet" "mtc_public_subnet" {
  vpc_id                  = aws_vpc.mtc_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags                    = var.subnet_tags
}

resource "aws_internet_gateway" "mtc_internet_gateway" {
  vpc_id = aws_vpc.mtc_vpc.id
  tags   = var.internet_gateway_tags
}

resource "aws_route_table" "mtc_public_rt" {
  vpc_id = aws_vpc.mtc_vpc.id
  tags   = var.route_table_tags
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.mtc_public_rt.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.mtc_internet_gateway.id
}

resource "aws_route_table_association" "mtc_public_assoc" {
  subnet_id      = aws_subnet.mtc_public_subnet.id
  route_table_id = aws_route_table.mtc_public_rt.id
}

resource "aws_security_group" "mtc_sg" {
  name        = var.sg_name
  description = "dev security group"
  vpc_id      = aws_vpc.mtc_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.sg_egress_cidr]
  }
}

resource "aws_key_pair" "mtc_auth" {
  key_name   = "mtckey"
  public_key = file("~/.ssh/mtckey.pub")
}

resource "aws_instance" "dev_node" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.mtc_auth.id
  vpc_security_group_ids = [aws_security_group.mtc_sg.id]
  subnet_id              = aws_subnet.mtc_public_subnet.id
  user_data              = file("userdata.tpl")
  monitoring             = true

  root_block_device {
    volume_size = 10
  }

  tags = var.instance_tags

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/mtckey"
    })
    interpreter = ["bash", "-c"]
  }
}