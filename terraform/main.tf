# This codebase will create the infrastructure module and the app module.

module "deploy-xyz-infrastructure" {
  source     = "./modules/infrastructure"
  project_id = var.project_id
  region     = var.region
}

module "deploy-xyz-app" {
  source = "./modules/app"
}