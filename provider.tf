
# creating a provider with aws 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# terraform {
#     backend "s3" {
#         bucket = "s3statebackenddsm"
#         dynamodb_table = "state-lock"
#         key = "global/mystatefile/terraform.tfstate" # the path you want to store you terraform
#         region = "us-east-1"
#         encrypt = true
#     }
#   required_providers {
#       aws = {
#           source = "hashicorp/aws"
#           #version = "4.20.0"
#       }
#   }
# }

provider "aws" {
  region     = "us-east-1"
#   access_key = "my-access-key"
#   secret_key = "my-secret-key"
}
