resource "aws_s3_bucket" "photoshare_bucket" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name        = var.bucket_name
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "photoshare_bucket_encrypt" {
  bucket = aws_s3_bucket.photoshare_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "photoshare_bucket_access" {
  bucket = aws_s3_bucket.photoshare_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}