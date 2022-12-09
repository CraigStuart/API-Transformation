resource "aws_lambda_function" "lambda_function" {

  function_name    = "api-transformation-text"
  role             = var.lambda_role
  image_uri        = "${var.lambda_ecr_url}:latest"
  package_type     = "Image"

  environment {
    variables = {
      "KAFKA_QUEUE_URL"    = var.bootstrap_brokers_tls
        }
    }
}
