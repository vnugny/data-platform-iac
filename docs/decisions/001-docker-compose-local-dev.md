# ADR 001: Docker Compose for local development

## Status
Accepted

## Context
Engineers need a one-command local environment that mirrors production topology (Airflow, Spark, object store, metadata DB) without requiring an AWS account.

## Decision
Use Docker Compose for local dev. Terraform is reserved for cloud environments (dev/prod on AWS). MinIO provides an S3-compatible object store locally so all S3 paths work unchanged in both environments.

## Consequences
- Any engineer can run `make up` and have a working stack in minutes
- Spark `spark-defaults.conf` points at MinIO; in production the same config key points at real S3
- Airflow LocalExecutor is used locally; production uses CeleryExecutor or MWAA
