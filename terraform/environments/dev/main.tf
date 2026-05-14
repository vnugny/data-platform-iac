terraform {
  required_version = ">= 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "data-platform-tfstate-dev"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

module "minio" {
  source      = "../../modules/minio"
  environment = "dev"
  bucket_names = ["bronze", "silver", "gold", "checkpoints"]
}

module "kafka" {
  source        = "../../modules/kafka"
  environment   = "dev"
  vpc_id        = var.vpc_id
  subnet_ids    = var.subnet_ids
  instance_type = "kafka.m5.large"
  broker_count  = 2
}

module "airflow" {
  source         = "../../modules/airflow"
  environment    = "dev"
  vpc_id         = var.vpc_id
  subnet_ids     = var.subnet_ids
  db_password    = var.airflow_db_password
  instance_class = "db.t3.medium"
}

module "warehouse" {
  source        = "../../modules/warehouse"
  environment   = "dev"
  vpc_id        = var.vpc_id
  subnet_ids    = var.subnet_ids
  node_type     = "ra3.xlplus"
  cluster_type  = "single-node"
  db_password   = var.warehouse_db_password
}
