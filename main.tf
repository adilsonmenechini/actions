terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "ci" {
  bucket = "criando-bucket-ci-00"
  acl    = "private"
}