resource "aws_kms_key" "parameter_encryption" {
  description             = "KMS key for encrypting SSM parameters"
  deletion_window_in_days = 7

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "Allow Lambda Role to decrypt",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/lambda-ssm-access-role"
        },
        Action    = ["kms:Decrypt"],
        Resource  = "*"
      },
      {
        Sid       = "Enable IAM User Permissions",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action    = "kms:*",
        Resource  = "*",
        Condition = {
          StringEquals = {
            "kms:CallerAccount" = "${data.aws_caller_identity.current.account_id}"
          }
        }
      }
    ]
  })
}

data "aws_caller_identity" "current" {}


output "kms_key_id" {
  value = aws_kms_key.parameter_encryption.key_id
}
