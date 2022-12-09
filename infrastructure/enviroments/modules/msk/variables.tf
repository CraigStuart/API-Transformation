variable "prefix" {
  type        = string
  default     = "prod-"
  description = "The string added at the beginning of each resource"
}

variable "vpc_private_subnets_id" {
  type        = tuple([string, string])
  description = "VPC private subnet ID"
}

variable "s3_msk_bucket" {
  type        = string
  description = "S3 bucket for MSK logs"
}

variable "sg_msk" {
  type        = string
  description = "Security group for msk traffic"
}

