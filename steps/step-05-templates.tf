data "template_file" "user_data_aws" {
  template = "${file("user_data.tpl")}"
  vars {
    var_cloud = "AWS"
    var_bgcolor = "lightblue"
  }
}


data "template_file" "user_data_gcp" {
  template = "${file("user_data.tpl")}"
  vars {
    var_cloud = "GCP"
    var_bgcolor = "lightgreen"
  }
}