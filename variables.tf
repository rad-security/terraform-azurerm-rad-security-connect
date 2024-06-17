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
