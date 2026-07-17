resource "aws_msk_cluster" "main" {
  cluster_name           = "${var.environment}-data-platform"
  kafka_version          = "3.6.0"
  number_of_broker_nodes = var.broker_count

  broker_node_group_info {
    instance_type   = var.instance_type
    client_subnets  = var.subnet_ids
    security_groups = [aws_security_group.msk.id]
    storage_info {
      ebs_storage_info {
        volume_size = 100
      }
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS_PLAINTEXT"
      in_cluster    = true
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.main.arn
    revision = aws_msk_configuration.main.latest_revision
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_security_group" "msk" {
  name_prefix = "${var.environment}-msk-"
  description = "MSK broker access for the ${var.environment} data platform"
  vpc_id      = var.vpc_id

  ingress {
    description = "Kafka TLS from within the VPC"
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_msk_configuration" "main" {
  name              = "${var.environment}-kafka-config"
  kafka_versions    = ["3.6.0"]
  server_properties = <<-EOT
    auto.create.topics.enable=false
    default.replication.factor=2
    min.insync.replicas=1
    num.partitions=6
    log.retention.hours=168
  EOT
}
