provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

provider "google" {
  credentials = "${file("${var.gcp_creds_file_path}")}"
  project     = "${var.gcp_project_id}"
  region      = "${var.gcp_region}"
}

variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "gcp_creds_file_path" {}
variable "gcp_project_id" {}
variable "gcp_region" {}
