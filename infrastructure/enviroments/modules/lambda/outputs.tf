output "aws_lambda_function" {
  value       = aws_lambda_function.lambda_function.arn
  description = "Lambda function arn"
}
