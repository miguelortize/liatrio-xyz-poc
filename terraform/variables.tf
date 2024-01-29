# GKE variables:

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

# VPC Variables:

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

# App Variables:

variable "repository" {
  description = "Container repository."
}

variable "image_version" {
  description = "Image of container to be deployed."
}