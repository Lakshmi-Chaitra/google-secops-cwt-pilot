// Project IDs
variable "project_1_id" {
  description = "The project ID for Project 1 (Bigtable)."
  type        = string
  default     = "ctp-prj-1"
}

variable "project_2_id" {
  description = "The project ID for Project 2 (Cloud Run and BigQuery)."
  type        = string
  default     = "ctp-prj-2"
}

// Bigtable and BigQuery details
variable "bigtable_instance_name" {
  description = "The name of the Bigtable instance."
  type        = string
  default     = "cloudrun-bigtable-instance"
}

variable "bigtable_table_name" {
  description = "The name of the Bigtable table."
  type        = string
  default     = "cloudrun-bigtable-table"
}

variable "bigquery_dataset_id" {
  description = "The ID of the BigQuery dataset."
  type        = string
  default     = "cloudrun_dataset"
}

variable "bigquery_table_id" {
  description = "The ID of the BigQuery table."
  type        = string
  default     = "cloudrun_table"
}

// Docker image
variable "docker_image" {
  description = "The Docker image to deploy in Cloud Run."
  type        = string
  default     = "us-central1-docker.pkg.dev/ctp-prj-2/cloud-run-source-deploy/online-banking-be:latest"
}

// Regions
variable "project_1_region" {
  description = "Region for Project 1."
  type        = string
  default     = "us-central1"
}

variable "project_2_region" {
  description = "Region for Project 2."
  type        = string
  default     = "us-central1"
}

// VPC names
variable "project_1_vpc_name" {
  description = "The name of the VPC for Project 1."
  type        = string
  default     = "project1-vpc"
}

variable "project_2_vpc_name" {
  description = "The name of the VPC for Project 2."
  type        = string
  default     = "project2-vpc"
}

// VPC Peering
variable "vpc_peering_name" {
  description = "The name of the VPC peering between Project 1 and Project 2."
  type        = string
  default     = "peering-project-1-to-project-2"
}
variable "cloud_run_name" {
  description = "The name of the Cloud Run service"
  type        = string
  default     = "cloudrun-service" // Set a valid default value if desired
}
variable "vpc_peering_name_1_to_2" {
  description = "Name of the VPC peering from Project 1 to Project 2"
  type        = string
  default     = "peering-project1-to-project2" // Valid peering name
}

variable "vpc_peering_name_2_to_1" {
  description = "Name of the VPC peering from Project 2 to Project 1"
  type        = string
  default     = "peering-project2-to-project1" // Valid peering name
}
