
resource "google_compute_instance" "jenkins" {
  name         = "jenkins-machine"
  machine_type = "e2-highcpu-8"
  zone         = "asia-south1-c"

  tags = ["name", "jenkins-machine", "allow-http"]

  boot_disk {
    initialize_params {
      image = "Ubuntu/Ubuntu 20.04 LTS"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    user-data = file("../../config/jenkins.sh")
  }

  metadata_startup_script = "echo hi > /test.txt"
}

#######################
# Network Access Rule
#######################

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"] // Adjust the source range as needed
  target_tags   = ["allow-http"]
}