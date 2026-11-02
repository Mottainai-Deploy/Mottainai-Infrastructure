# Official account settings. Supply values via a local ignored *.tfvars file.
variable "region" {
  description = "Approved AWS region for the official environment."
  type        = string
  nullable    = false
}

variable "allowed_account_id" {
  description = "Expected official AWS account ID; provider access is restricted to this account."
  type        = string
  sensitive   = true
  nullable    = false

  validation {
    condition     = can(regex("^[0-9]{12}$", var.allowed_account_id))
    error_message = "allowed_account_id must be a 12-digit AWS account ID."
  }
}
