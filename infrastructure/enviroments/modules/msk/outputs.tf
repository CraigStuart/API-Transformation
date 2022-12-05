output "aws_sqs_text_transformation_arn" {
  value       = aws_sqs_queue.terraform_queue.arn
  description = "ARN of text transformation SQS"
}

output "aws_sqs_text_transformation_url" {
  value       = aws_sqs_queue.terraform_queue.url
  description = "URL of text transformation SQS"
}

output "aws_sqs_text_transformation_poll_url" {
  value       = aws_sqs_queue.terraform_queue_poll.url
  description = "URL of text transformation SQS Poll"
}

