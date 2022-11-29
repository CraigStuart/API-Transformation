output "aws_bucket" {
  value       = aws_s3_bucket.default.arn
  description = "Name of lambda S3 bucket"
}


