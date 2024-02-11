terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.15.0"
    }
  }
}

provider "google" {
  project     = "famous-segment-405421"
  zone        = "asia-south1-c"
  credentials = "./key.json"
}