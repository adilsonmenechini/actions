terraform {
  backend "s3" {
    bucket = "eks-tfstate-trinovati"
    key    = "ci/terraform.tfstate"
    region = "us-west-2"
  }
}
