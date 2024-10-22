terraform {
  backend "s3" {
    bucket = "tf-state-movieapi-23323454"
    key = "global/tfmovieapi.tfstate"
    region = "eu-central-1"
    dynamodb_table = "tf-state-lock-table-movieapi-100987676"
  }
}