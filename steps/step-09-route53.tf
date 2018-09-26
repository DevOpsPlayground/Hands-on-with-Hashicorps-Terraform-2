
resource "aws_route53_record" "domain-aws" {
  zone_id = "${var.aws_route53_zone_id}"
  name    = "${var.playground_animal}"
  type    = "A"
  ttl     = "1"
  records = [
    "${aws_instance.blue_instance.public_ip}"
  ]
  weighted_routing_policy {
    weight = 127
  }

  set_identifier = "${var.playground_animal}-aws"
}
resource "aws_route53_record" "domain-gcp" {
  zone_id = "${var.aws_route53_zone_id}"
  name    = "${var.playground_animal}"
  type    = "A"
  ttl     = "1"
  set_identifier = "${var.playground_animal}-gcp"
  records = [
    "${google_compute_instance.green_instance.network_interface.0.access_config.0.assigned_nat_ip}"
  ]
  weighted_routing_policy {
    weight = 127
  }

}

variable "aws_route53_zone_id" {}
