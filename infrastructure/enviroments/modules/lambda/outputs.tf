output "aws_lambda_role" {
  value       = aws_iam_role.iam_for_lambda.arn
  description = "Name of Lambda role"
}

output "aws_lambda_function" {
  value       = aws_lambda_function.lambda_function.arn
  description = "Lambda function arn"
}
