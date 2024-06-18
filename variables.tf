variable "rad_security_app_id" {
  type        = string
  default     = "55bd48fb-0aea-469d-b464-b5aa1490941d"
  description = "The ID of the Rad Security Azure application."
}

variable "rad_security_role_name" {
  type        = string
  default     = "rad-security-connect"
  description = "Name of custom role to assume"
}

variable "azure_subscriptions" {
  type        = list(string)
  default     = []
  description = "List of Azure subscriptions to connect to Rad Security. Subscriptions must be passed in the form /subscriptions/$SUBSCIRPTION_ID"
}
