resource "aws_s3_bucket" "storage" {
  bucket        = var.s3_bucket_name
  force_destroy = var.s3_force_destroy
  tags          = { Name = var.s3_bucket_name }
}

resource "aws_s3_bucket_versioning" "storage_versioning" {
  bucket = aws_s3_bucket.storage.id
  versioning_configuration { status = var.s3_versioning_status }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "storage_crypto" {
  bucket = aws_s3_bucket.storage.id
  rule {
    apply_server_side_encryption_by_default { sse_algorithm = var.s3_encryption_algorithm }
  }
}

resource "aws_s3_bucket_public_access_block" "storage_public_block" {
  bucket                  = aws_s3_bucket.storage.id
  block_public_acls       = var.s3_bucket_is_public ? false : true
  block_public_policy     = var.s3_bucket_is_public ? false : true
  ignore_public_acls      = var.s3_bucket_is_public ? false : true
  restrict_public_buckets = var.s3_bucket_is_public ? false : true
}
