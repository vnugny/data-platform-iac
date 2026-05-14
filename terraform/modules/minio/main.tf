resource "aws_s3_bucket" "lakehouse" {
  for_each = toset(var.bucket_names)
  bucket   = "${var.environment}-lakehouse-${each.key}"

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_s3_bucket_versioning" "lakehouse" {
  for_each = aws_s3_bucket.lakehouse
  bucket   = each.value.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bronze_expiry" {
  bucket = aws_s3_bucket.lakehouse["bronze"].id
  rule {
    id     = "expire-raw-after-90-days"
    status = "Enabled"
    expiration {
      days = 90
    }
  }
}
