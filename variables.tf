variable "s3_bucket_name" {
  description = "Nombre unico global obligatorio para la asignacion del Bucket S3"
  type        = string
  default     = "vampirenightxx-storage-bucket-xxxx"
}

variable "s3_bucket_is_public" {
  description = "Interruptor logico: true libera el acceso publico; false bloquea todo"
  type        = bool
  default     = true
}

variable "s3_force_destroy" {
  description = "Boton de panico: true permite borrar el bucket con archivos dentro"
  type        = bool
  default     = false
}

variable "s3_versioning_status" {
  description = "Estado para el control de versiones (Enabled o Suspended)"
  type        = string
  default     = "Enabled"
}

variable "s3_encryption_algorithm" {
  description = "Algoritmo de cifrado por defecto del lado del servidor"
  type        = string
  default     = "AES256"
}
