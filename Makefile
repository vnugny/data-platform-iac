.PHONY: up down build logs ps clean tf-init tf-plan tf-apply tf-destroy

COMPOSE = docker compose -f docker/docker-compose.yml

# ─── Local dev environment ───────────────────────────────────────────────────

build:
	$(COMPOSE) build

up: build
	$(COMPOSE) up airflow-init
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down -v --remove-orphans

# ─── Terraform ───────────────────────────────────────────────────────────────

ENV ?= dev

tf-init:
	cd terraform/environments/$(ENV) && terraform init

tf-plan:
	cd terraform/environments/$(ENV) && terraform plan -var-file=terraform.tfvars

tf-apply:
	cd terraform/environments/$(ENV) && terraform apply -var-file=terraform.tfvars

tf-destroy:
	cd terraform/environments/$(ENV) && terraform destroy -var-file=terraform.tfvars
