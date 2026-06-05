# Configuración práctica del entorno de pruebas para validar el módulo de S3

provider "aws" {
  region = "us-east-1"
}

module "almacenamiento_prueba" {
  source = "../../" # Referencia al código local ubicado en la raíz del repositorio

  # Configuración del bucket basado en las variables del módulo
  s3_bucket_name          = "vampirenightxx-storage-test-12345"
  s3_bucket_is_public     = true    # Abre el bloque de acceso y aplica la policy pública
  s3_force_destroy        = true    # Facilita la limpieza del laboratorio con terraform destroy
  s3_versioning_status    = "Enabled"
  s3_encryption_algorithm = "AES256"
}

# (Recuerda definir estos outputs en tu archivo outputs.tf en la raíz del módulo)
output "nombre_del_bucket" {
  description = "Nombre final del bucket desplegado"
  value       = module.almacenamiento_prueba.bucket_id
}
