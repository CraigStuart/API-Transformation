output "aws_ecs_cluster" {
  value       = aws_ecs_cluster.streamlit.arn
  description = "ECS Cluster arn"
}
