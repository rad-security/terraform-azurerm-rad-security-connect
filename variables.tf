variable "rad_security_app_id" {
  type        = string
  default     = "4ba48a95-c5da-41d1-897a-57bdf7e34e5b"
  description = "The ID of the Rad Security Azure application."
}

variable "rad_security_role_name" {
  type        = string
  default     = "rad-security-connect"
  description = "Name of custom role to assume"
}
