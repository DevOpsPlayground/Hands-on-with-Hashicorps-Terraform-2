# DevOps Playground #24: Hands-on with Terraform

![Terraform Logo](https://raw.githubusercontent.com/ecsdigital/devopsplayground24-terraform/master/assets/terraform_logo.png)

## Introduction

On this meetup we'll be deploying a web service into AWS and GCP with some basic DNS based load-balancing using terraform only.

**Name:** Daniel Meszaros

**Role:** DevOps And Continuous Delivery Consultant

**Email:** daniel.meszaros@ecs-digital.co.uk

**Linkedin:** https://www.linkedin.com/in/meszarosdaniel/

## Requirements

* Modern browser with JS enabled or Terminal or Putty
* Minimal knowledge of how an ssh terminal works.
* Basic AWS and/or GCP knowledge

## Setup

* Open the web terminal (web terminal: http://{your_hostname}.devopsplayground.com)
* Your Actual host name and user/pass are assigned at the start of the presentation.
* Log in to your instance.
* You are set.

## Steps

### 1. Setup Providers

We need to configure the providers first, so we can use the desired cloud provider.

edit the `provider.tf` file with the following contents:

```bash
provider "aws" {
    region = "us-east-1"
}
```

Then:

```bash
terraform init
terraform plan
terraform apply
```

### 2. Create EC2 instance in AWS

Edit the `main.tf` and add the following:

```bash
resource "aws_instance" "ec2_ubuntu" {
  instance_type="t2.micro"
  ami = "ami-06b5810be11add0e2"
}
```

Then:

```bash
terraform plan
terraform apply
```

### 3. State file

`terraform apply` collects meta-data to a file called `terraform.tfstate`. Here you can find the actual attirbutes of a resource like instance id, ip address,etc.

Bonus trick:
To find out what's your instance's external IP address without using the AWS CLI or the web console, you can do the following:

```bash
echo "aws_instance.ec2_ubuntu.public_ip" | terraform console
```

Now you should be able to use `ping` to find out if your newly created instance is available.

### 4. Add the GCP provider to the existing file

Edit the provider.tf and add the following:

```bash
provider "google" {
    region = "europe-west1"
    project = "<project_id>"
}
```

Now try to run `terraform plan`. Notice, that it will not run due to the fact that we've defined a new provider but haven't initialised it's terraform libraries.
Run `terraform init` again.


### 5. Add GCP instance configuration

Edit the `main.tf` file and add the following:

```bash

```

Bonus trick No.2:

```bash
echo "google_compute_instance.gcp_ubuntu.network_interface.0.access_config.0.nat_ip" | terraform console
```

### 6. Replace attributes with variables

Let's imagine, that we don't like to bake in the name of our instances into source control, but we'd like to deploy them in pairs, with the same serial number.

For that we can use variable. Create a new file called `variables.tf` and add the following code:

```bash
variable "serial_no" {
    description = "Common serial number for the instances"
}
```

Now we have to replace the names in the 2 resource configurations in the `main.tf` accordingly:

```bash
resource "aws_instance" "ec2_ubuntu" {
  ...
  tags {
    Name = "aws-${var.serial_no}"
  }
}

resource "google_compute_instance" "gcp_ubuntu" {
  ...
  name = "gcp-${var.serial_no}"
  ...
  ...
}
```

Run `terraform plan` and enter some value. Inspect the changes it'll do to your instances to match the desired state.
Run `terraform apply` and enter the required data

For further automation reasons you can give values to your variables at runtime, or prior running the terraform command.

Environment variables: `TF_VAR_SERIAL_NO=abcd`
or
Runtime argument: `terraform plan -var serial_no=abcd`
or
`terraform.tfvars` file:

```bash
serial_no = "abcd"
```

### 7. Outputs

How nice it would be if we can output the ip addresses at every run, or if we could pick it up as json programatically.

We can define outputs in terraform which can supply us any argument that is stored in the state file

Create an `outputs.tf` with the following content:

```bash
output "aws_ip" {
    value = "${aws_instance.ec2_ubuntu.public_ip}"
}

output "gcp_ip" {
    value = "${google_compute_instance.gcp_ubuntu.network_interface.0.access_config.0.nat_ip}"
}
```

### 8. Destroy

Don't forget to destroy your demo instances.
Issue the following command `terraform destroy` to clean the AWS and the Google Cloud providers.

## Survey

Please help us improve by filling this survey out. Only takes about 2 minutes, and your help is greatly appreciated:
/////// SURVEY LINK ///////

## Useful links

* 