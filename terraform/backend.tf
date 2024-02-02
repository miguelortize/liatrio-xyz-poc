terraform {
  backend "gcs" {
    bucket = "xyz-liatrio"
    prefix = "terraform/state"
  }
}
