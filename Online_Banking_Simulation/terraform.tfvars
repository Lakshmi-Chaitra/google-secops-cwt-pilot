
project_id         = "ctp-prj-1"
region             = "europe-west1"
organization_id    = "486803701224"
vpc_bt_sql         = "vpc-bt-sql"
vpc_cloud_run      = "vpc-cloud-run"
vpc_gke_pd         = "vpc-gke-pd"
subnet_gke_pd_name = "subnet-gke-pd"

subnets_cloud_run = [
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

subnets_gke_pd = [
  {
    name   = "subnet-gke-pd-01"
    cidr   = "10.0.18.0/24"
    region = "asia-southeast1"
  },
  {
    name   = "subnet-gke-pd-02"
    cidr   = "10.1.18.0/24"
    region = "asia-east2"
  },
  {
    name   = "subnet-gke-pd-03"
    cidr   = "10.2.18.0/24"
    region = "europe-west2"
  },
  {
    name   = "subnet-gke-pd-04"
    cidr   = "10.3.18.0/24"
    region = "europe-west1"
  }
]

subnets_bt_sql = [
  {
    name   = "subnet-bt-sql-01"
    cidr   = "10.0.19.0/24"
    region = "europe-west1"
  },
  {
    name   = "subnet-bt-sql-02"
    cidr   = "10.1.19.0/24"
    region = "europe-west2"
  },
  {
    name   = "subnet-bt-sql-03"
    cidr   = "10.2.19.0/24"
    region = "us-east4"
  },
  {
    name   = "subnet-bt-sql-04"
    cidr   = "10.3.19.0/24"
    region = "asia-south1"
  },
  {
    name   = "subnet-bt-sql-05"
    cidr   = "10.4.19.0/24"
    region = "asia-east2"
  }
]
cloud_run_metadata = {
  labels = {
    "env" = "production"
    "app" = "my-app"
  }
  annotations = {
    "autoscaling.knative.dev/minScale" = "1"
    "autoscaling.knative.dev/maxScale" = "10"
  }
}

cloud_run_service_name = "cloud-run-app"
cloud_run_regions      = ["europe-west1", "asia-east2"]
gke_pd_regions         = ["asia-southeast1", "asia-east2", "europe-west2", "europe-west1"]
bt_sql_regions         = ["europe-west1", "europe-west2", "us-east4", "asia-south1", "asia-east2"]
bt_regions             = ["asia-east2", "europe-west2"]
image_url              = "us-central1-docker.pkg.dev/ctp-prj-1/cloud-run-source-deploy/online-banking-fe:latest"

# Backend service URLs for environment variables
ml_checking_account_service_endpoint = "https://us-central1-docker.pkg.dev/ctp-prj-1/cloud-run-source-deploy/online-banking-ml"
ml_savings_account_service_endpoint  = "https://us-central1-docker.pkg.dev/ctp-prj-1/cloud-run-source-deploy/online-banking-ml" # Replace this with the correct URL if necessary

# Load balancer configuration
backend_service_name_prefix = "cloudrun-backend"

cloud_run_service_urls = {
  "asia-east2"   = "https://asia-east2-run-url"
  "europe-west1" = "https://europe-west1-run-url"
}
pod_replicas = 1
pod_image    = "us-central1-docker.pkg.dev/ctp-prj-1/cloud-run-source-deploy/online-banking-ml:latest"

provider_map = {
  "asia-southeast1" = "asia_southeast1"
  "asia-east2"      = "asia_east2"
  "europe-west2"    = "europe_west2"
  "europe-west1"    = "europe_west1"
}