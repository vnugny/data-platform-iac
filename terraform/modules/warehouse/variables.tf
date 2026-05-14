variable "environment"  { type = string }
variable "vpc_id"       { type = string }
variable "subnet_ids"   { type = list(string) }
variable "node_type"    { type = string }
variable "cluster_type" { type = string }
variable "db_password"  { type = string; sensitive = true }
