output "cluster_endpoint" {
  description = "Redshift cluster endpoint"
  value       = aws_redshift_cluster.main.endpoint
}

output "cluster_id" {
  description = "Redshift cluster identifier"
  value       = aws_redshift_cluster.main.id
}

output "iam_role_arn" {
  description = "IAM role Redshift uses to read from S3"
  value       = aws_iam_role.redshift_s3.arn
}
