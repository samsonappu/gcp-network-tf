provider "google" {
    credentials = var.gcp_creds
    project  = "argocd-deployment"
    region = "us-west2"
}

variable "gcp_creds" {
default= ""
}
