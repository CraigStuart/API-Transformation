output "aws_sqs_text_transformation_arn" {
  value       = aws_sqs_queue.terraform_queue.arn
  description = "ARN of text transformation SQS"
}
