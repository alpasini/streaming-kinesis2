# HCL - Hashicorp Configuration Language
# Linguagem declarativa

resource "aws_s3_bucket" "datalake" {
  #Parametros de configuração do recurso escolhido
  bucket = "${var.base_bucket_name}-${var.ambiente}-${var.numero_conta}"

  tags = {
    IES   = "IGTI"
    CURSO = "EDC"
  }
}

resource "aws_s3_bucket_acl" "datalake" {
    bucket = aws_s3_bucket.datalake.id
    acl    = "private"
}

# Criptografia em Rest utilizando algorítimo default do S3 (AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "datalake" {
  bucket = aws_s3_bucket.datalake.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Sobe um arquivo para o S3 criado acima
resource "aws_s3_object" "codigo_spark" {
  bucket = aws_s3_bucket.datalake.id
  key    = "emr-code/pyspark/job_spark_from_tf.py"
  acl    = "private"
  source = "../data/job_spark.py"
  etag   = filemd5("../data/job_spark.py") #verifica se houve mudança no arquivo, se não houve, não copia novamente
}

provider "aws" {
  region = "us-east-2"
}