variable "ecs_role" {
  type = string
  description = "ecs role"
}

variable "region" {
  type = string
  default = "eu-central-1"
  description = "default region"
}

variable "log_group_ecs_containers" {
  type = string
  default = "ecs_container_logs_group"
  description = "ECS container log group"
}

variable "log_group_ecs_cluster" {
  type = string
  default = "ecs_cluster_logs_group"
  description = "ECS cluster log group"
}

variable "ecr_url" {
  type = string
  description = "ecr url"
}

variable "vpc_private_subnets_id" {
  type        = list
  description = "Vpc private subnet ids"
}

variable "ecs_sg_id" {
  type        = string
  description = "ECS sg"
}

variable "alb_tg_id" {
  type        = string
  description = "Alb tg id"
}

variable "ecs_container_name" {
  type        = string
  default     = "streamlit-app-prod"
  description = "Nmae of container"
}

variable "aws_bucket_variables" {
  type        = string
  description = "Streamlit FE variables"
}
