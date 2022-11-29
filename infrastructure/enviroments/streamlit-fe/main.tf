module "queue_sqs" {
  source = "../modules/queue"
}

module "setup" {
  source = "../modules/setup"
}

module "ecr" {
  source = "../modules/ecr"
}

module "iam" {
  source = "../modules/iam"
}

module "ecs" {
  source   = "../modules/ecs"
  ecs_role = module.iam.aws_ecs_role_name
  ecr_url  = module.ecr.aws_ecr_repo_url
}

module "lambda" {
  source = "../modules/lambda"
  lambda_role = module.iam.aws_lambda_role_name
  sqs_arn = module.queue_sqs.aws_sqs_text_transformation_arn
}

module "s3" {
  source = "../modules/s3"
}

module "vpc" {
  source = "../modules/vpc"
}

module "sg" {
  source = "../modules/sg"
}

#module "app" {
#  source = "../../modules/app"
#
#  environment = var.environment
#  prefix      = var.prefix
#}

#module "ecs" {
#  source = "../../modules/ecs"
#
#  prefix = var.prefix
#}
#
#module "vpc" {
#  source = "../../modules/vpc"
#
#  prefix = var.prefix
#}
#
