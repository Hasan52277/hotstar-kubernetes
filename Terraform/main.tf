terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
}

# SECURITY GROUP (ONLY SSH)
resource "aws_security_group" "ec2_security_group" {

  name        = "hotstar-security-group"
  description = "Allow SSH only"

  ingress {
    description = "SSH"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hotstar-security-group"
  }
}

# EC2 INSTANCE
resource "aws_instance" "monitoring_server" {

  ami           = "ami-091138d0f0d41ff90"
  instance_type = "t2.micro"

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2_security_group.id
  ]

  tags = {
    Name = var.instance_name
  }
}
