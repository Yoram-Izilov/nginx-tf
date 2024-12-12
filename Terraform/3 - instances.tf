# NGINX instance
resource "aws_instance" "nginx_ec2" {
  ami                    = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  associate_public_ip_address = false
  security_groups        = [aws_security_group.nginx_sg.name]

  user_data = <<-EOF
                #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              docker run -d -p 80:80 nginx
              EOF

  tags = {
    Name = "nginx-ec2"
  }
}