locals {
  runtime = module.cloud_functions.runtime
}

module "cloud_functions" {
  source  = "../../../provisioners/terraform/modules/gcp-cloud-functions"
  runtime = var.cloud_function_configuration.runtime
}

resource "google_cloudfunctions_function" "main" {
  name                  = var.md_metadata.name_prefix
  labels                = var.md_metadata.default_tags
  runtime               = local.runtime
  entry_point           = var.cloud_function_configuration.entrypoint
  available_memory_mb   = var.cloud_function_configuration.memory_mb
  min_instances         = var.cloud_function_configuration.minimum_instances
  max_instances         = var.cloud_function_configuration.maximum_instances
  source_archive_bucket = google_storage_bucket.main.name
  source_archive_object = google_storage_bucket_object.main.name

  # not exposed only to make the bundle "simpler"
  # default: 60  (s)
  # max    : 540 (s)
  timeout = 120

  event_trigger {
    # https://cloud.google.com/functions/docs/calling/pubsub#event_types
    # hard-coded, this is the only pubsub event type for Cloud Functions
    event_type = "google.pubsub.topic.publish"
    resource   = var.topic.data.infrastructure.grn
    failure_policy {
      retry = false
    }
  }

  depends_on = [
    module.apis
  ]
}
