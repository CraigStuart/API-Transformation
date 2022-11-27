#data "terraform_remote_state" "common" {
#  backend = "s3"
#
#  config.tf {
#      # Replace this with your bucket name!
#      bucket         = "terraform-up-and-running-state-archivec"
#      key            = "global/s3/terraform.tfstate"
#      region         = "eu-central-1"
#      dynamodb_table = "terraform-up-and-running-locks"
#      encrypt        = true
#    }
#}

resource "aws_sqs_queue" "terraform_queue" {
  name                        = "${var.prefix}api-stream.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  sqs_managed_sse_enabled     = true
}

