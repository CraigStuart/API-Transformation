resource "aws_lambda_function" "lambda_function" {

  function_name    = "api-transformation-prod"
  role             = var.lambda_role
  handler          = "lambda_function.lambda_handler"
  s3_bucket        = "api-transformation-packages"
  s3_key           = "regex-deployment-package.zip"
  architectures    = ["x86_64"]
  runtime          = "python3.9"

  #todo fix hardcoding
  environment {
    variables = {
      "KAFKA_QUEUE_URL"    = var.kafka_url
        }
    }
}

