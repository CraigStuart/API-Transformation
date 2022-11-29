variable "prefix" {
  type        = string
  default     = ""
  description = "The string added at the beginning of each resource"
}

variable "lambda_role" {
  type = string
  description = "lambda role"
}

variable "sqs_arn" {
  type        = string
  description = "SQS Arn"
}