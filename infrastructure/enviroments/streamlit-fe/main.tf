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
