module "vpc" {
  source = "../modules/vpc"
}

module "sg" {
  source   = "../modules/sg"
  vpc_id   = module.vpc.vpc_id
}

module "lb" {
  source                 = "../modules/lb"
  vpc_public_subnets_id  = module.vpc.vpc_public_subnets_id
  vpc_private_subnets_id = module.vpc.vpc_private_subnets_id
  vpc_id                 = module.vpc.vpc_id
  alb_sg_id              = module.sg.alb_sg_id
}

module "s3" {
  source = "../modules/s3"
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
  source                 = "../modules/ecs"
  ecs_role               = module.iam.aws_ecs_role_name
  ecr_url                = module.ecr.aws_ecr_repo_url
  ecs_sg_id              = module.sg.ecs_sg_id
  vpc_private_subnets_id = module.vpc.vpc_private_subnets_id
  alb_tg_id              = module.lb.alb_tg_id
  aws_bucket_variables   = module.s3.aws_bucket_variables
}

module "lambda" {
  source                = "../modules/lambda"
  lambda_role           = module.iam.aws_lambda_role_name
  lambda_ecr_url        = module.ecr.aws_ecr_repo_url_lambda
  bootstrap_brokers_tls = module.msk.bootstrap_brokers_tls
}

module "msk" {
  source                    = "../modules/msk"
  vpc_private_subnets_id    = module.vpc.vpc_private_subnets_id
  s3_msk_bucket             = module.s3.aws_bucket_mks_logs
  sg_msk                    = module.sg.msk_sg_id
}

