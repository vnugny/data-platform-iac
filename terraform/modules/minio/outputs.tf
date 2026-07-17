output "bucket_ids" {
  description = "Map of layer name to S3 bucket id"
  value       = { for k, b in aws_s3_bucket.lakehouse : k => b.id }
}

output "bucket_arns" {
  description = "Map of layer name to S3 bucket ARN"
  value       = { for k, b in aws_s3_bucket.lakehouse : k => b.arn }
}
