// AWS AMI ID: ami-06b5810be11add0e2

resource "aws_instance" "ec2_ubuntu" {
  instance_type="t2.micro"
  ami = "ami-06b5810be11add0e2"
  tags {
    Name = "aws-${var.serial_no}"
  }
}

resource "google_compute_instance" "gcp_ubuntu" {
  machine_type = "f1-micro"
  name = "gcp-${var.serial_no}"
  zone = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1404-lts"
    }
  }
  network_interface {
    network = "default"

    access_config {}
  }
}