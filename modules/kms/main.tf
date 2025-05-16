
resource "aws_kms_key" "parameter_encryption" {
  description             = "KMS key for encrypting parameter store values"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

output "kms_key_id" {
  value = aws_kms_key.parameter_encryption.key_id
}
