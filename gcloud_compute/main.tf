terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
        }
    }
}

provider "google" {
    version = "3.5.0"
    credentials = file("../../../../.ssh/gcloudkey.json")
    project = "jenkins-x-indradip"
    region = "us-west1"
    zone = "us-west1-b"    
}

resource "google_compute_network" "vpc_network" {
    name = "default"
}