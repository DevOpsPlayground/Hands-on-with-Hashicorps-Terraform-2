output "aws_ip" {
    value = "${aws_instance.ec2_ubuntu.public_ip}"
}

output "gcp_ip" {
    value = "${google_compute_instance.gcp_ubuntu.network_interface.0.access_config.0.nat_ip}"
}