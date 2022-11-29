output "alb_sg" {
  value       = aws_security_group.sg_alb.arn
  description = "SG api-stream-alb-security-group"
}
