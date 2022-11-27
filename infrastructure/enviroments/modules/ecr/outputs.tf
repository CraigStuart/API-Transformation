output "aws_ecr_arn" {
  value       = aws_sqs_queue.text_queue.arn
  description = "ARN of game-scores SQS"
}
