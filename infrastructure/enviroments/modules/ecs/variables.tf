variable "ecs_role" {
  type = string
  description = "ecs role"
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
