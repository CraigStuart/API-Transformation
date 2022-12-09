output "alb_sg_arn" {
  value       = aws_security_group.sg_alb.arn
  description = "Sg alb arn"
}

output "alb_sg_id" {
  value       = aws_security_group.sg_alb.id
  description = "Sg alb id"
}

output "ecs_sg_id" {
  value       = aws_security_group.sg_ecs.id
  description = "Sg alb id"
}

output "msk_sg_id" {
  value       = aws_security_group.sg_msk.id
  description = "Sg mks id"
}
