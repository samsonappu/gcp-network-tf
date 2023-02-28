provider "google" {
    credentials = file("~/.json")
    project  = "cloud-automation"
    region = "us-west2"
}