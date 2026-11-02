output "account_id" {
  description = "AWS account selected by the active credential chain."
  value       = data.aws_caller_identity.current.account_id
}

output "region" {
  description = "AWS region selected for this environment."
  value       = data.aws_region.current.name
}
