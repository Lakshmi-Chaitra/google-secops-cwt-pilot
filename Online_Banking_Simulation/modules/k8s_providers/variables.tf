variable "gke_clusters" {
  type = map(object({
    endpoint             = string
    master_auth_token    = string
    ca_certificate       = string
  }))
}