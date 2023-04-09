terraform {
#  backend "local" {
#    path = "terraform.tfstate"
#  }

  backend "s3" {
    bucket = ""
    key = ""
    region = ""
  }
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}