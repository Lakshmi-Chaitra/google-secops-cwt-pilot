project_id = "ctp-prj-1"
vpc_name   = "new-cwt-pilot-01"
subnets = [
  {
    name              = "subnet-cloud-run-01"
    cidr_block        = "10.0.14.0/24"
    region            = "europe-west4"         # Add the region attribute
  },
  {
    name              = "subnet-gke-pd-01"
    cidr_block        = "10.0.15.0/24"
    region            = "europe-west4"         # Add the region attribute
  },
  {
    name              = "subnet-bt-sql-01"
    cidr_block        = "10.0.16.0/24"
    region            = "europe-west4"         # Add the region attribute
  }
]

