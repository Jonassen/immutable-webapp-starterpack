provider "aws" {
  version = "~> 2.0"
  region  = "eu-north-1"
}

resource "aws_s3_bucket" "host-b" {
  bucket = "swagger-dagger-test-sky-host"

  tags = {
    Environment = "Test"
    Managed     = "Terraform"
  }
}

resource "aws_s3_bucket" "asset-b" {
  bucket = "swagger-dagger-test-sky-asset"

  tags = {
    Environment = "Test"
    Managed     = "Terraform"
  }
}

resource "aws_s3_bucket_policy" "host-b-policy" {
  bucket = "swagger-dagger-test-sky-host"
  policy = templatefile("policy/public_bucket.json.tpl", { bucket_arn = aws_s3_bucket.host-b.arn })
}

resource "aws_s3_bucket_policy" "asset-b-policy" {
  bucket = "swagger-dagger-test-sky-asset"
  policy = templatefile("policy/public_bucket.json.tpl", { bucket_arn = aws_s3_bucket.asset-b.arn })
}

output "host" {
  value = aws_s3_bucket.host-b.bucket_domain_name
}

output "asset" {
  value = aws_s3_bucket.asset-b.bucket_domain_name
}
