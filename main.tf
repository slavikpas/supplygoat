resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-data"
  region        = "us-west-2"
  acl           = "public-read"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-data"
    Environment = local.resource_prefix.value
    git_org     = "slavikpas"
    git_repo    = "supplygoat"
    yor_trace   = "998d9db7-596c-4d6a-85d0-ee55ad6a460f"
  }
}

resource "aws_s3_bucket_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  region = "us-west-2"
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"
  tags = {
    Name        = "${local.resource_prefix.value}-customer-master"
    Environment = local.resource_prefix.value
    git_org     = "slavikpas"
    git_repo    = "supplygoat"
    yor_trace   = "764546e7-6c99-4227-ba2e-023f6077afcd"
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  region        = "us-west-2"
  acl           = "private"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-financials"
    Environment = local.resource_prefix.value
    git_org     = "slavikpas"
    git_repo    = "supplygoat"
    yor_trace   = "ad5c9a61-c667-48c3-b899-b7200c663b81"
  }

}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket = "${local.resource_prefix.value}-operations"
  region = "us-west-2"
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-operations"
    Environment = local.resource_prefix.value
    git_org     = "slavikpas"
    git_repo    = "supplygoat"
    yor_trace   = "221de67b-20f1-4d0e-a7c3-625de1646245"
  }

}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  region = "us-west-2"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  force_destroy = true
  tags = {
    git_org   = "slavikpas"
    git_repo  = "supplygoat"
    yor_trace = "a0da063f-ed3a-4d45-a9d0-083f306e4fce"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  region = "us-west-2"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      }
    }
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
    git_org     = "slavikpas"
    git_repo    = "supplygoat"
    yor_trace   = "97bdbf66-d0f0-48e6-99ea-5a0903fc081c"
  }
}
