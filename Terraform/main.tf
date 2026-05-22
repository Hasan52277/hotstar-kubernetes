terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Security Group
resource "aws_security_group" "ec2_security_group" {

  name        = "hotstar-security-group"
  description = "Allow SSH, Jenkins, HTTP, SMTP"

  # SSH Port
  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Port
  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins Port
  ingress {

    description = "Jenkins"

    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # SMTP Port
  ingress {

    description = "SMTP TLS"

    from_port = 587
    to_port   = 587
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Gmail SMTP SSL
  ingress {

    description = "Gmail SMTP SSL"

    from_port = 465
    to_port   = 465
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Custom Port 493
  ingress {

    description = "Custom Port"

    from_port = 493
    to_port   = 493
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Traffic
  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hotstar-security-group"
  }
}

# EC2 Instance
resource "aws_instance" "monitoring_server" {

  ami = "ami-091138d0f0d41ff90"

  instance_type = "t3.large"

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2_security_group.id
  ]

  tags = {
    Name = var.instance_name
  }
}
