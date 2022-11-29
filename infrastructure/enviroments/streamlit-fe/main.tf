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

#module "ecs" {
#  source = "../modules/ecs"
#}
#
#module "lambda" {
#  source = "../modules/lambda"
#}

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
