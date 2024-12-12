# Security Group for EKS
resource "aws_security_group" "nginx_ec2" {
  vpc_id = aws_vpc.main.id
  name   = "nginx_ec2_sg"

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OpenVPN Security Group"
  }
}