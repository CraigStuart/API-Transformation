# Import modules
module "lambda" {
  source = "../iam"
}

# Setup Lambda function
resource "aws_lambda_function" "lambda_function" {

  function_name    = "api-transformation-prod"
  role             = module.lambda.aws_lambda_role_name
  handler          = "lambda_function.lambda_handler"
  s3_bucket        = "api-transformation-packages"
  s3_key           = "regex-deployment-package.zip"
  architectures    = ["x86_64"]
  runtime          = "python3.9"
}

# Import SQS parameters
module "sqs" {
  source = "../queue"
}

# Setup lambda trigger using SQS
resource "aws_lambda_event_source_mapping" "lambda_sqs_trigger" {
  batch_size        = 1
  event_source_arn  = module.sqs.aws_sqs_text_transformation
  enabled           = true
  function_name     = aws_lambda_function.lambda_function.arn
}

