module "kms" {
  source = "./modules/kms"
}

module "sns" {
  source        = "./modules/sns"
  topic_name    = "param-change-topic"
  email_address = var.notification_email
}

module "parameter_store" {
  source     = "./modules/parameter_store"
  kms_key_id = module.kms.kms_key_id
}

module "eventbridge" {
  source         = "./modules/eventbridge"
  sns_topic_arn  = module.sns.topic_arn
  parameter_name = module.parameter_store.parameter_name
}

module "lambda" {
  source = "./modules/lambda"
}
