#Create a security group for the ALB
resource "aws_security_group" "sg_alb" {
  name        = "api-stream-alb-security-group"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"] #Lock down cidr range in a prod environment
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_ecs" {
  name        = "api-stream-ecs-security-group"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 8501
    to_port     = 8501
    security_groups = [aws_security_group.sg_alb.id] #all traffic is routed via the sg_alb
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




