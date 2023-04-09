provider "aws" {
  region = "ap-south-1"
  shared_credentials_files = "<path>"

  default_tags {
    tags = {
      "Owner" = "Manan"
      "Provisioned" = "Terraform"
      "Environment" = terraform.workspace
    }
  }
}