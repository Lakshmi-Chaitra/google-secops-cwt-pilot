resource "google_bigquery_dataset" "bq_dataset" {
  dataset_id = var.bigquery_dataset_id
  location   = var.project_2_region
  project    = var.project_2_id
}

resource "google_bigquery_table" "bq_table" {
  dataset_id          = google_bigquery_dataset.bq_dataset.dataset_id
  table_id            = var.bigquery_table_id
  deletion_protection = false
  project             = var.project_2_id
  schema = jsonencode([
    {
      name = "id"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "name"
      type = "STRING"
      mode = "NULLABLE"
    },
    {
      name = "age"
      type = "INTEGER"
      mode = "NULLABLE"
    },
    {
      name = "created_at"
      type = "TIMESTAMP"
      mode = "REQUIRED"
    }
  ])
}
resource "google_cloud_run_service" "cloud_run" {
  name     = var.cloud_run_name
  location = var.project_2_region
  project  = var.project_2_id

  template {
    spec {
      containers {
        image = var.docker_image

        env {
          name  = "BIGTABLE_INSTANCE_NAME"
          value = "var.bigtable_instance_id"
        }
        env {
          name  = "BIGTABLE_TABLE_NAME"
          value = "var.bigtable_table_id"
        }
        env {
          name  = "BIGQUERY_DATASET_NAME"
          value = var.bigquery_dataset_id
        }
        env {
          name  = "BIGQUERY_TABLE_NAME"
          value = var.bigquery_table_id
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

// Grant public (unauthenticated) access to the Cloud Run service
resource "google_cloud_run_service_iam_member" "noauth" {
  location = google_cloud_run_service.cloud_run.location
  project  = google_cloud_run_service.cloud_run.project
  service  = google_cloud_run_service.cloud_run.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
