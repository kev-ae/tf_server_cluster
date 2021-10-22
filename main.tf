provider "aws" {
  region = "us-east-2"
}

resource "aws_launch_configuration" "instance" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = ["aws_security_group.instance.id"]

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello World" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-security-group"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = tcp
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.instance.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  max_size = 10
  min_size = 2

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}
variable "server_port" {
  description = "The port of the web server"
  type        = number
  default     = 8080
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}