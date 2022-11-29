resource "aws_lambda_function" "lambda_function" {

  function_name    = "api-transformation-prod"
  role             = var.lambda_role
  handler          = "lambda_function.lambda_handler"
  s3_bucket        = "api-transformation-packages"
  s3_key           = "regex-deployment-package.zip"
  architectures    = ["x86_64"]
  runtime          = "python3.9"
}

# Setup lambda trigger using SQS
resource "aws_lambda_event_source_mapping" "lambda_sqs_trigger" {
  batch_size        = 1
  event_source_arn  = var.sqs_arn
  enabled           = true
  function_name     = aws_lambda_function.lambda_function.arn
}

