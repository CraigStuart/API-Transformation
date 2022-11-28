module "queue_sqs" {
  source = "../modules/queue"
}

module "setup" {
  source = "../modules/setup"
}

module "ecr" {
  source = "../modules/ecr"
}

module "ecs" {
  source = "../modules/ecs"
}

module "iam" {
  source = "../modules/iam"
}

module "lambda" {
  source = "../modules/lambda"
}

module "s3" {
  source = "../modules/s3"
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
#module "lb" {
#  source = "../../modules/lb"
#
#  prefix = var.prefix
#}
#
