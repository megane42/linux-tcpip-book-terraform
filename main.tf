module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "linux-tcpip-book-terraform-vpc"
  cidr   = "10.0.0.0/16"

  azs             = [ "${local.region}a", "${local.region}c" ]
  private_subnets = [ "10.0.1.0/24",   "10.0.2.0/24",   "10.0.3.0/24"   ]
  public_subnets  = [ "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24" ]

  enable_nat_gateway = false
  single_nat_gateway = true
}

resource "aws_security_group" "ssh" {
  name        = "linux-tcpip-book-terraform-ssh"
  description = "allow ssh from specific ips"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.ssh_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami                         = "ami-0a5866d87afdfdfd3"
  instance_type               = "t2.micro"
  key_name                    = local.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [ aws_security_group.ssh.id ]
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  tags = {
    Name = "linux-tcpip-book-terraform-ec2"
  }
}
