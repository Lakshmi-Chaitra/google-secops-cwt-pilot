variable "neg_list" {
  description = "List of Network Endpoint Groups for Cloud Run"
  type        = map(string)
}

variable "lb_region" {
  description = "Region where the Load Balancer's external IP is created"
  type        = string
}
