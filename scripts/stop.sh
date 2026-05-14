#!/usr/bin/env bash
set -euo pipefail

echo "==> Stopping data platform local environment..."
make down
echo "==> Done. Run 'make clean' to also remove volumes."
