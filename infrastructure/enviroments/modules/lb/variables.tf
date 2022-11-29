variable "prefix" {
  type        = string
  default     = ""
  description = "The string added at the beginning of each resource"
}

variable "vpc_public_subnets_id" {
  type        = list
  description = "Vpc public subnet ids"
}

variable "vpc_private_subnets_id" {
  type        = list
  description = "Vpc private subnet ids"
}

variable "vpc_id" {
  type        = string
  description = "Vpc ID"
}

variable "alb_sg_id" {
  type        = string
  description = "Alb sg id"
}

