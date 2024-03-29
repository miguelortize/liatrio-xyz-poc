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

variable "cluster_name" {
  description = "The name of the GKE cluster"
}

# VPC Variables:

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}