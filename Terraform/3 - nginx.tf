# NGINX instance
resource "aws_instance" "nginx_ec2" {
  ami                         = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_a.id
  associate_public_ip_address = false
  security_groups             = [aws_security_group.nginx_sg.name]

  user_data = <<-EOF
                #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              docker run -d -p 80:80 nerdfromhell/yo-nginx
              EOF

  tags = {
    Name = "nginx-ec2"
  }
}

# Create an Application Load Balancer
resource "aws_lb" "nginx_alb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx_sg.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  enable_deletion_protection = false

  tags = {
    Name = "NGINX ALB"
  }
}

# Create a target group for the ALB
resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Create a listener for the ALB
resource "aws_lb_listener" "nginx_http_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}

# Register the NGINX instance in the target group
resource "aws_lb_target_group_attachment" "nginx_ec2_attachment" {
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = aws_instance.nginx_ec2.id
  port             = 80

  lifecycle {
    ignore_changes = [target_id]
  }
}