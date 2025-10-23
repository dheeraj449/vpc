provider "aws" {
  region = var.region
}

resource "aws_security_group" "web_pages" {
  name        = "web_pages"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "web"
    Project = "web server"
  }
}

resource "aws_instance" "web_ec2" {
  ami                    ="ami-02d26659fd82cf299" 
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.web_pages.id]

  tags = {
    Name    = "web"
    Project = "web"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              if [ -f /etc/httpd/conf.d/welcome.conf ]; then
                  rm -f /etc/httpd/conf.d/welcome.conf
              fi
              echo "Welcome to Depos!" > /var/www/html/index.html
              systemctl enable httpd
              systemctl restart httpd
              EOF
}
