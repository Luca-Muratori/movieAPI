provider "aws" {
  region = "eu-central-1"
}


//bucket creation
module "s3" {
  source = "./modules/bucket"
}

module "cloudfront" {
  source = "./modules/cloudfront"
}