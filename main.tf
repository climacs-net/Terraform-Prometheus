provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform_aws_key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "prometheus_demo" {
  ami             = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM)
  instance_type   = "t2.micro"
  availability_zone = "us-east-1b"
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    Name = "prometheus-demo"
  }
}

output "instance_id" {
  value = aws_instance.prometheus_demo.id
}

output "public_ip" {
  value = aws_instance.prometheus_demo.public_ip
}
