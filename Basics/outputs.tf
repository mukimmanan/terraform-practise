output "bucket_arn" {
  description = "AWS S3 Bucket ARN"
  value = aws_s3_bucket.bucket.arn
  sensitive = true
}