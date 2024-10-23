data "aws_s3_bucket" "movieapi-223769697" {
  bucket = "movieapi-223769697"
}

/////////////////////////////////////////
resource "aws_cloudfront_distribution" "movieapi_distribution" {
  enabled             = true
  default_root_object = "index.html"
  origin {
    domain_name = data.aws_s3_bucket.movieapi-223769697.bucket_regional_domain_name
    origin_id   = "S3Origin"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3Origin"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for website"
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.movieapi_distribution.domain_name
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.movieapi_distribution.id
}
