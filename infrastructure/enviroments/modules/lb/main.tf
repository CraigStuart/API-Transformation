resource "aws_lb" "default" {
  name            = "alb-api-stream"
  subnets         = var.vpc_public_subnets_id
  security_groups = [var.alb_sg_id]
}

resource "aws_lb_target_group" "api-stream-tg" {
  name        = "api-stream-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "api-stream-alb" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.api-stream-tg.id
    type             = "forward"
  }
}