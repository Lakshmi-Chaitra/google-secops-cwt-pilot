variable "project_id" {
  type        = string
  description = "The project ID where the VPC network will be created."
}

variable "region" {
  type        = string
  description = "The region where the resources will be deployed."
  default     = "us-central1"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC network."
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name               = string
    cidr_block         = string
    region             = string
  }))
}


