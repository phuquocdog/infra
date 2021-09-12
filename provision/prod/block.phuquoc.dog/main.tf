resource "aws_s3_bucket" "b" {
  bucket = "block.phuquoc.dog"
  acl    = "public-read"

  tags = {
    Name = "My block.phuquoc.dog"
  }
}

locals {
  s3_origin_id = "myS3Origin"
}

module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = ["block.phuquoc.dog"]

  comment             = "My awesome CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }
  default_root_object = "index.html"

  logging_config = {
  }

  origin = {
    something = {
      domain_name = "block.phuquoc.dog"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1"]
      }
    }
     s3_one = {
      domain_name = "block.phuquoc.dog.s3.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "something"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/*"
      target_origin_id       = "s3_one"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    }
  ]
  viewer_certificate = {
    acm_certificate_arn = "arn:aws:acm:us-east-1:001955506259:certificate/5532b918-87a1-4232-8bc0-7650a11456dd"
    ssl_support_method  = "sni-only"
  }
}