output "alb_sg_arn" {
  value       = aws_security_group.sg_alb.arn
  description = "Sg alb arn"
}

output "alb_sg_id" {
  value       = aws_security_group.sg_alb.id
  description = "Sg alb id"
}
