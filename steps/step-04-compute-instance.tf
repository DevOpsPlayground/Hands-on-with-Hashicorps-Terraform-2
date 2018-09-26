
resource "google_compute_instance" "green_instance" {
  name         = "pg24-${var.playground_animal}"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1404-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }
}
