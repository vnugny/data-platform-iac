variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_id" {
  description = "VPC to deploy into"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for MSK, RDS, Redshift"
  type        = list(string)
}

variable "airflow_db_password" {
  description = "RDS password for Airflow metadata DB"
  type        = string
  sensitive   = true
}

variable "warehouse_db_password" {
  description = "Redshift admin password"
  type        = string
  sensitive   = true
}
