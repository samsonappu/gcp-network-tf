provider "google" {
    credentials = var.gcp-creds
    project  = "cloud-automation"
    region = "us-west2"
}

variable "gcp-creds" {
default= ""
}
