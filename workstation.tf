module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "work station"

  instance_type          = "t2.micro"
  ami = "ami-03265a0778a880afb"  # devops practice that is centos8
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = "subnet-0a98ad411cda9a460"
  user_data = file("docker.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_all_minikube"
  description = "Allow all traffic for minikube"

  ingress {
    description      = "all traffic from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_all_minikube"
  }
}