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

resource "aws_kms_key" "key" {
  enable_key_rotation  = true
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket-ci"
  acl    = "log-delivery-write"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "ci" {
  bucket = "criando-bucket-ci-00"
  acl    = "private"

  tags = {
    Name        = "Bucket terraform"
    Environment = "Dev"
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


