output "s3_bucket_name" {
  description = "ID del bucket creado"
  value       = aws_s3_bucket.storage.id
}

output "s3_bucket_url" {
  description = "URL publica del bucket"
  value       = "https://${aws_s3_bucket.storage.bucket}.s3.amazonaws.com"
}
