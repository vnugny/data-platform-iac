#!/usr/bin/env bash
set -euo pipefail

echo "==> Starting data platform local environment..."

# Check dependencies
for cmd in docker docker-compose; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "ERROR: $cmd is required but not installed."; exit 1; }
done

# Build images
echo "==> Building images..."
make build

# Run Airflow DB migrations + create admin user
echo "==> Initialising Airflow..."
make up

echo ""
echo "==> Services ready:"
echo "    Airflow:      http://localhost:8080  (admin / admin)"
echo "    Spark UI:     http://localhost:8090"
echo "    MinIO:        http://localhost:9001  (minioadmin / minioadmin)"
echo ""
echo "==> Lakehouse buckets: bronze, silver, gold, checkpoints"
