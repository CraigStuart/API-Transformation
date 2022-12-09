output "aws_bucket" {
  value       = aws_s3_bucket.default.arn
  description = "Name of lambda S3 bucket"
}

output "aws_bucket_variables" {
  value       = aws_s3_bucket.stream.arn
  description = "Name of streamlit fe variables S3 bucket"
}

output "aws_bucket_mks_logs" {
  value       = aws_s3_bucket.msk_logs.id
  description = "Name of streamlit msk logs S3 bucket"
}


