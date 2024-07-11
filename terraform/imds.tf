provider "aws" {
  region = "us-east-1"
}
resource "aws_security_group" "bastion-host-sg" {
  name        = "bastion-host-sg"
  description = "Security group for the attack server"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
resource "aws_instance" "example" {
  ami             = "ami-0c7217cdde317cfec"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.bastion-host-sg.name]
  tags = {
    Name      = "bastion-host"
  }
  metadata_options {
    http_tokens = "false
  }
}