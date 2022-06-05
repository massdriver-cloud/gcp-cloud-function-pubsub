module "apis" {
  source = "github.com/massdriver-cloud/terraform-google-enable-apis"
  services = [
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com"
  ]
}
