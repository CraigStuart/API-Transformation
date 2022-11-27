output "aws_ecr_name" {
  value       = aws_ecr_repository.ecr_registry.name
  description = "Name of ECR"
}

output "aws_ecr_repo_url" {
  value       = aws_ecr_repository.ecr_registry.repository_url
  description = "Name of ECR"
}
