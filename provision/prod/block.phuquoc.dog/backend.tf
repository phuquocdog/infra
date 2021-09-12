# For cloudfront, the acm has to be created in us-east-1 or it will not work
provider "aws" {
  region = "ap-southeast-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

terraform {
  backend "s3" {
    bucket = "phuquocdog-infra"
    key    = "provision/prod/block.phuquoc.dog.tfstate"
    region = "us-west-2"
  }
}


# data "terraform_remote_state" "router53" {
#   backend = "s3"
#   config = {
#     bucket = "quest-prod-tf-states"
#     key    = "provision/prod/router53.tfstate"
#     region = "ap-southeast-1"
#   }
# }

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}