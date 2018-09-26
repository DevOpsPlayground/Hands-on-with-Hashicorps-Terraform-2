output "gcp_ip" {
  value = "${google_compute_instance.green_instance.network_interface.0.access_config.0.assigned_nat_ip}"
}
output "aws_ip" {
  value = "${aws_instance.blue_instance.public_ip}"
}