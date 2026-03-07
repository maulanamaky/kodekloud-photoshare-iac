output "s3_bucket_name"{
    value = aws_s3_bucket.photoshare_bucket.bucket
}

output "s3_bucket_id"{
    value = aws_s3_bucket.photoshare_bucket.id
}

output "s3_bucket_arn"{
    value = aws_s3_bucket.photoshare_bucket.arn
}