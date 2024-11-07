project_id      = "ctp-prj-1"
region          = "europe-west1"
cloud_run_service_name         = "cloud-run-app"
cloud_run_regions = [ "europe-west1","asia-east2"]
image_url      = "us-central1-docker.pkg.dev/ctp-prj-1/cloud-run-source-deploy/online-banking-fe:latest"
cloud_run_metadata = {
  labels = {
    "env"       = "production"
    "app"       = "my-app"
  }
  annotations = {
    "autoscaling.knative.dev/maxScale" = "10"
    "autoscaling.knative.dev/minScale" = "1"
  }
}

subnets = [
  {
    name   = "subnet-cloud-run-01"
    cidr   = "10.0.17.0/24"
    region = "europe-west1"
  },
  {
    name   = "subnet-cloud-run-02"
    cidr   = "10.1.17.0/24"
    region = "asia-east2"
  }

]

cloud_run_service_urls = {
  "asia-east2" = "https://asia-east2-run-url"
  "europe-west1" = "https://europe-west1-run-url"
}

