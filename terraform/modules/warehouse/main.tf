resource "aws_redshift_subnet_group" "main" {
  name       = "${var.environment}-redshift"
  subnet_ids = var.subnet_ids
}

resource "aws_redshift_cluster" "main" {
  cluster_identifier        = "${var.environment}-data-warehouse"
  database_name             = "datawarehouse"
  master_username           = "admin"
  master_password           = var.db_password
  node_type                 = var.node_type
  cluster_type              = var.cluster_type
  cluster_subnet_group_name = aws_redshift_subnet_group.main.name
  skip_final_snapshot       = true

  iam_roles = [aws_iam_role.redshift_s3.arn]

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_role" "redshift_s3" {
  name = "${var.environment}-redshift-s3"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "redshift.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "redshift_s3" {
  role       = aws_iam_role.redshift_s3.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
