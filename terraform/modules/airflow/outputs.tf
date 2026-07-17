output "db_endpoint" {
  description = "Airflow metadata DB endpoint (host:port)"
  value       = aws_db_instance.airflow.endpoint
}

output "db_address" {
  description = "Airflow metadata DB hostname"
  value       = aws_db_instance.airflow.address
}

output "execution_role_arn" {
  description = "IAM role assumed by Airflow tasks"
  value       = aws_iam_role.airflow_execution.arn
}
