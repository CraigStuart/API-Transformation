resource "aws_sqs_queue" "terraform_queue" {
  name                        = "${var.prefix}api-stream.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  sqs_managed_sse_enabled     = true
}

resource "aws_sqs_queue" "terraform_queue_poll" {
  name                        = "${var.prefix}api-stream-poll.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
  sqs_managed_sse_enabled     = true
}
