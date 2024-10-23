# data "aws_cloudfront_origin_access_identity" "oai" {
#   id = 
# }

resource "aws_s3_bucket" "movieapi-223769697" {
  bucket = "movieapi-223769697"
}

#s3 bucket config for website hosting
resource "aws_s3_bucket_website_configuration" "movieapi-website" {
  bucket = aws_s3_bucket.movieapi-223769697.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

#allow cloudfront access
#resource "aws_s3_bucket_policy" "movieapi-website-bucket-policy" {
#  bucket = aws_s3_bucket.movieapi-223769697.id
#
#  policy = jsonencode({
#    Version ="2012-10-17"
#    Statement=[
#      {
#        Sid="AllowCloudFrontAccess"
#        Effect ="Allow"
#        Principal ={
#          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
#        }
#        Action ="s3:GetObject"
#        Resource ="${aws_s3_bucket.movieapi-223769697.arn}/*"
#      }
#    ]
#  })
#}

output "website_bucket_id" {
  value = aws_s3_bucket.movieapi-223769697.id
}
output "website_bucket_name" {
  value = aws_s3_bucket.movieapi-223769697.bucket
}