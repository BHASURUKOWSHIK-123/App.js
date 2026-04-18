resource "aws_security_group" "alb_sg" {
  name   = "$alb-sg"
  vpc_id = var.vpc_id

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
    Name = "alb-sg"
  }

}

resource "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  security_groups = [aws_security_group.vpc_endpoint_sg.id]
  }
  
  tags = {
    Name = "ecs-sg"
  }

}
