resource "aws_s3_bucket" "stream" {
  #Parametros de configuração do recurso escolhido
  bucket = "igti-pasini-streaming-bucket"

  tags = {
    IES   = "IGTI"
    CURSO = "EDC"
  }
}

# Criptografia em Rest utilizando algorítimo default do S3 (AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "stream" {
  bucket = aws_s3_bucket.stream.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

