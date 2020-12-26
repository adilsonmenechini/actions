terraform {
  backend "s3" {
    encrypt = true
    bucket = "eks-tfstate-trinovati"
    key    = "ci/terraform.tfstate"
    region = "us-west-2"
  }
}
