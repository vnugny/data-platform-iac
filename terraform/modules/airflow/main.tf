resource "aws_db_subnet_group" "airflow" {
  name       = "${var.environment}-airflow-db"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "airflow" {
  identifier             = "${var.environment}-airflow-metadata"
  engine                 = "postgres"
  engine_version         = "15.6"
  instance_class         = var.instance_class
  allocated_storage      = 20
  db_name                = "airflow"
  username               = "airflow"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.airflow.name
  skip_final_snapshot    = true
  deletion_protection    = false

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_role" "airflow_execution" {
  name = "${var.environment}-airflow-execution"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_full" {
  role       = aws_iam_role.airflow_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
