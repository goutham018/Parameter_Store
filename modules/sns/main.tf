
resource "aws_sns_topic" "notification" {
  name = var.topic_name
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.notification.arn
  protocol  = "email"
  endpoint  = var.email_address
}

variable "topic_name" {
  type = string
}

variable "email_address" {
  type = string
}

output "topic_arn" {
  value = aws_sns_topic.notification.arn
}
