#terraform {
#  required_version = ">= 0.12, < 0.13"
#}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      ProjectName = "${var.project_name}"
      Creator     = "tng@chegwin.org"
      Hostname    = "${var.Hostname}"
    }
  }
}

