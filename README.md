# Módulo de Terraform para Almacenamiento AWS (Amazon S3)

## Objetivos del repositorio
El objetivo de este repositorio es proporcionar un componente de infraestructura modular dedicado a la creación y gestión del ciclo de vida de los datos mediante Amazon S3. Está diseñado para ser altamente flexible, permitiendo desplegar tanto buckets de almacenamiento privado seguro como buckets públicos para la distribución de contenido estático web.

## Propósito general del código Terraform
Este código automatiza la configuración avanzada de un bucket S3. Sus funciones principales son:
* Creación del bucket con soporte para destrucción forzada (`force_destroy`) en caso de contener objetos.
* Activación del control de versiones (`aws_s3_bucket_versioning`) para proteger los datos contra sobreescrituras accidentales.
* Configuración de cifrado por defecto del lado del servidor (`SSE-S3` con `AES256`).
* Gestión dinámica del Bloqueo de Acceso Público (Public Access Block), controlable mediante un interruptor lógico booleano.
* Inyección de una Política de Bucket (`aws_s3_bucket_policy`) que permite la lectura pública global (`s3:GetObject`), la cual se aplica de forma segura esperando a que se liberen los bloqueos previos.

## Instrucciones básicas de uso

### Requisitos previos
* Terraform instalado (versión `>= 1.0.0`).
* Credenciales de AWS configuradas en el entorno local.

### Ejemplo de invocación
Para utilizar este módulo en tu entorno principal u orquestador, añade el siguiente bloque a tu archivo `main.tf`:

```hcl
module "storage" {
  source = "[github.com/AVAUY1105Grupo1/terraform-aws-s3-auy1105-grupo-1?ref=v1.0.0](https://github.com/AVAUY1105Grupo1/terraform-aws-s3-auy1105-grupo-1?ref=v1.0.0)"

  s3_bucket_name          = "mi-bucket-proyecto-grupo1-prod"
  s3_bucket_is_public     = true
  s3_force_destroy        = false
  s3_versioning_status    = "Enabled"
  s3_encryption_algorithm = "AES256"
}
```
## Variables de Entrada (Inputs)
Este módulo se parametrizó utilizando las siguientes variables:

* s3_bucket_name (string): Nombre único global obligatorio para la asignación del Bucket S3.

* s3_bucket_is_public (bool): Interruptor lógico: true libera el acceso público y aplica la política de lectura; false bloquea todo acceso público.

* s3_force_destroy (bool): Botón de pánico: true permite borrar el bucket mediante Terraform incluso si contiene archivos dentro.

* s3_versioning_status (string): Estado para el control de versiones (Enabled o Suspended).

* s3_encryption_algorithm (string): Algoritmo de cifrado por defecto del lado del servidor.

## Variables de Salida (Outputs)
(Asegúrate de tener un archivo outputs.tf en la raíz de este módulo con lo siguiente):

* bucket_id: El nombre identificador del bucket creado.

* bucket_arn: El Amazon Resource Name (ARN) del bucket S3.
