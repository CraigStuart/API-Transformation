output "aws_ecs_role_name" {
  value       = aws_iam_role.ecs_role.arn
  description = "ECS Task execution role"
}

