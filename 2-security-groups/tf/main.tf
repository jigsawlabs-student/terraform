provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name = "model-deploy"
  vpc_security_group_ids = [aws_security_group.app_security.id, aws_security_group.ssh_backend_security.id]


  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 80 &
              EOF
}

resource "aws_security_group" "app_security" {
  name = "app_security"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_backend_security" {
    name = "ssh backend security"

    ingress {
        cidr_blocks = [
          "0.0.0.0/0"
        ]
    from_port = 22
        to_port = 22
        protocol = "tcp"
      }

      egress {
       from_port = 0
       to_port = 0
       protocol = "-1"
       cidr_blocks = ["0.0.0.0/0"]
     }
}
