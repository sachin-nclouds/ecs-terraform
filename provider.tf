provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

provider "aws" {
  alias  = "ohio"
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket         = "sachin-terraform"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-sachin"
  }
}