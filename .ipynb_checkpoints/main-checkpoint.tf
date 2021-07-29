
provider "aws" {
  region = "us-east-2"
  shared_credentials_file = "/Users/jeff/.aws/credentials"
  profile                 = "default"
}

resource "aws_instance" "first_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-server"
  }
}
