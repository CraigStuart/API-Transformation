variable "prefix" {
  type        = string
  default     = ""
  description = "The string added at the beginning of each resource"
}

variable "lambda_role" {
  type = string
  description = "lambda role"
}

variable "lambda_ecr_url" {
  type = string
  description = "lambda ecr url"
}

variable "bootstrap_brokers_tls" {
  type = string
  description = "Kafka broker URL"
}
