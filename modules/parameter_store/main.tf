
resource "aws_ssm_parameter" "config_param" {
  name      = "/app/config/api_key"
  type      = "SecureString"
  value     = "super-secret-key"
  key_id    = var.kms_key_id
  overwrite = true
}

variable "kms_key_id" {
  type = string
}

output "parameter_name" {
  value = aws_ssm_parameter.config_param.name
}
