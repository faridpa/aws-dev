data "aws_ami" "server_ami" {
  most_recent = true
  owners      = [var.owners]

  filter {
    name   = "name"
    values = [var.values]
  }
}