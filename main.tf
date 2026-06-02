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

# NUEVO RECURSO: Asigna los permisos de lectura publica a internet para todos los objetos del bucket
resource "aws_s3_bucket_policy" "storage_public_policy" {
  bucket = aws_s3_bucket.storage.id

  # Usamos jsonencode para estructurar de forma limpia la politica nativa de AWS IAM
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.storage.arn}/*"
      }
    ]
  })

  # CRITICO: La politica no se puede aplicar hasta que el bloque de acceso publico se haya removido por completo
  depends_on = [aws_s3_bucket_public_access_block.storage_public_block]
}
