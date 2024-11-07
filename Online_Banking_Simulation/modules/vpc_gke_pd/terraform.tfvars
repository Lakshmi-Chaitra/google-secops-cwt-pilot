project_id = "ctp-prj-1"
region     = "europe-west1"

network_name = "vpc-gke-pd"
subnets = [
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

gke_pd_regions = ["asia-southeast1", "asia-east2", "europe-west2", "europe-west1"]

pod_replicas = 1
pod_image    = "us-central1-docker.pkg.dev/ctp-prj-1/cloud-run-source-deploy/online-banking-ml:latest"

provider_map = {
   "asia-southeast1"   = "asia_southeast1"
    "asia-east2"        = "asia_east2"
    "europe-west2"      = "europe_west2"
    "europe-west1"      = "europe_west1"
}