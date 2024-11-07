project_id = "ctp-prj-1"
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
bt_sql_regions = ["europe-west1", "europe-west2", "us-east4", "asia-south1", "asia-east2"]
bt_regions     = ["asia-east2", "europe-west2"]
vpc_bt_sql     = "vpc-bt-sql"