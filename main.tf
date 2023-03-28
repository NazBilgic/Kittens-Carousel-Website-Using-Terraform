terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sinan" {
    ami = "ami-no"
    instance_type = "t2.micro"
    key_name = "key-name"
    security_groups = ["tf-sec-sg"]
    user_data       = filebase64("user-data.sh")
    tags = {
        Name = "terraform-ile-project"
  }
  
}

resource "aws_security_group" "tf-sec-gr" {
  name = "tf-sec-sg"
  tags = {
    Name = "tf-provisioner-sg"
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      protocol = "tcp"
      to_port = 22
      cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
      from_port = 0
      protocol = -1
      to_port = 0
      cidr_blocks = [ "0.0.0.0/0" ]
  }
}