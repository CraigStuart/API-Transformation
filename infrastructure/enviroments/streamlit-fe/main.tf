module "queue_sqs" {
  source = "../modules/queue"
}

module "setup" {
  source = "../modules/setup"
}

#module "app" {
#  source = "../../modules/app"
#
#  environment = var.environment
#  prefix      = var.prefix
#}

#module "ecr" {
#  source = "../../modules/ecr"
#
#  prefix = var.prefix
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
