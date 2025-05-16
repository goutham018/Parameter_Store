
resource "aws_cloudwatch_event_rule" "parameter_change" {
  name        = "parameter-store-change-rule"
  description = "Triggers on Parameter Store changes"
  event_pattern = jsonencode({
    "source": ["aws.ssm"],
    "detail-type": ["Parameter Store Change"],
    "detail": {
      "name": [var.parameter_name],
      "operation": ["Update"]
    }
  })
}

resource "aws_cloudwatch_event_target" "sns" {
  rule = aws_cloudwatch_event_rule.parameter_change.name
  arn  = var.sns_topic_arn
}

variable "sns_topic_arn" {
  type = string
}

variable "parameter_name" {
  type = string
}
