output "s3_bucket_arn" {
  value       = aws_s3_bucket.backend.arn
  description = "The arn of the s3 bucket that holds that state"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.locks.name
  description = "The name of the table of locks"
}