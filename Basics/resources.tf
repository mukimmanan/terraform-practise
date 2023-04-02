resource "aws_s3_bucket" "bucket" {
  bucket = "<name of the bucket>"
  tags = {
    Name = "S3 Bucket"
    Purpose = "Terraform practise"
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
    bucket = aws_s3_bucket.bucket.id
    acl = "private"
}

resource "aws_security_group" "sec_group" {
  name = "web_server_inbound"
  description = "Allow inbound traffic on tcp/443"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow 443 from the internet"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_block = ["0.0.0.0/0"]
  }

  tags {
    Name = "web_server_inbound"
  }
}