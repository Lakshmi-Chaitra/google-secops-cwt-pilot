variable "service_account_name" {
  description = "Name of the service account"
  type        = string
}

variable "namespace" {
  description = "Namespace where the service account will be created"
  type        = string
}

variable "role_name" {
  description = "Name of the role to be created"
  type        = string
}

variable "role_binding_name" {
  description = "Name of the role binding to be created"
  type        = string
}

variable "resources" {
  description = "List of resources the role can access"
  type        = list(string)
}

variable "verbs" {
  description = "List of verbs the role can perform"
  type        = list(string)
}
