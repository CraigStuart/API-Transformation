variable "prefix" {
  type        = string
  default     = ""
  description = "The string added at the beginning of each resource"
}

variable "lambda_role" {
  type = string
  description = "lambda role"
}

variable "kafka_url" {
  type = string
  description = "Kafka broker URL"
  default = "z-2.streamlittest.yqgpyq.c8.kafka.eu-central-1.amazonaws.com:2181,z-3.streamlittest.yqgpyq.c8.kafka.eu-central-1.amazonaws.com:2181,z-1.streamlittest.yqgpyq.c8.kafka.eu-central-1.amazonaws.com:2181"
}
