variable "project_id" {
  description = "GCP project ID"
  type        = string
}


variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}

variable "cloud_run_regions" {
  description = "List of regions where Cloud Run will be deployed"
  type        = list(string)
}

variable "cloud_run_metadata" {
  description = "Metadata for Cloud Run services"
  type = object({
    labels      = map(string)
    annotations = map(string)
  })
}

variable "image_url" {
  description = "URL of the Docker image for Cloud Run"
  type        = string
}

variable "ml_checking_account_service_endpoint" {
  description = "ML Checking Service Endpoint URL"
  type        = string
}

variable "ml_savings_account_service_endpoint" {
  description = "ML Savings Service Endpoint URL"
  type        = string
}

variable "neg_list" {
  description = "List of network endpoint group (NEG) ids to associate with the backend service."
  type        = map(string)  # or list(string) depending on your data structure
}

variable "cloud_run_service_name" {
  description = "List of Cloud Run services for each region."
  type        = string
}