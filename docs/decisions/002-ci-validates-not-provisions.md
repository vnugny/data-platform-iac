# ADR 002: CI validates and lints; it does not provision or boot the stack

## Status
Accepted

## Context
The first CI attempt built both container images (Airflow + Spark) on every push
and then booted Postgres and MinIO to run live health checks. That pipeline was
slow (multi-minute image builds pulling apt packages and Maven jars), network-
dependent (any Maven or Debian mirror hiccup turned the build red), and it
duplicated work that `make up` already does locally. It also gated the whole
repo on infrastructure that only exists to run the stack, not to define it.

For an infrastructure-definition repo, the thing CI should protect is the
correctness of the definitions: is the Terraform well-formed and internally
consistent, are the Dockerfiles free of known footguns, is the Compose file a
valid spec.

## Decision
CI runs three fast, deterministic jobs:

- **Terraform** — `terraform fmt -check -recursive` and `terraform validate`
  against the dev environment (`-backend=false`, no cloud credentials).
- **hadolint** — lints each Dockerfile against best-practice rules.
- **Compose** — `docker compose config --quiet` validates and interpolates the
  Compose file without building images or starting containers.

Building the images and running the stack end-to-end stays a local activity
(`make up` / `docker compose build`), and cloud provisioning stays a deliberate
`terraform apply` — neither belongs on the critical path of every push.

## Consequences
- CI is fast and does not flake on registry or mirror availability.
- Definition-level regressions (bad HCL, unpinned/again-root Dockerfile steps,
  malformed Compose) are caught on every push.
- CI does **not** prove the images build or the stack comes up healthy; that is
  verified locally before a change lands. A nightly or on-demand workflow could
  add the heavier build+smoke path later if it becomes worth the runtime.
