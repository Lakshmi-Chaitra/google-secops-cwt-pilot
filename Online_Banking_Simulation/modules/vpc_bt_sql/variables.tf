variable "project_id" {
  type = string
}

variable "vpc_bt_sql" {
  type = string
}

variable "subnets_bt_sql" {
  type = list(object({
    name   = string
    cidr   = string
    region = string
  }))
}


variable "bt_sql_regions" {
  type        = list(string)
  description = "Regions for Bigtable and Cloud SQL"
}

variable "bt_regions" {
  type        = list(string)
  description = "Regions for Bigtable "
}
