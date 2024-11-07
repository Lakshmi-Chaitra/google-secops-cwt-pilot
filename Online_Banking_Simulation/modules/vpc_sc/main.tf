resource "google_access_context_manager_service_perimeter" "vpc_sc" {
  name        = "vpc-sc"
  title       = "Service Perimeter for VPC"
  parent = "accessPolicies/${google_access_context_manager_access_policy.org_policy.name}"
  
  status {
    // Configuration details
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_access_context_manager_access_policy" "org_policy" {
  parent = "organizations/486803701224"  # Replace with your organization ID
  title  = "cwt-pilot-org-policy"
  lifecycle {
    prevent_destroy = false
  }
}
