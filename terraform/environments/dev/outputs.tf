output "lakehouse_bucket_ids" {
  description = "S3 bucket ids for each medallion layer"
  value       = module.minio.bucket_ids
}

output "kafka_bootstrap_brokers_tls" {
  description = "MSK TLS bootstrap brokers for producers/consumers"
  value       = module.kafka.bootstrap_brokers_tls
}

output "airflow_db_endpoint" {
  description = "Airflow metadata database endpoint"
  value       = module.airflow.db_endpoint
}

output "warehouse_endpoint" {
  description = "Redshift warehouse endpoint"
  value       = module.warehouse.cluster_endpoint
}
