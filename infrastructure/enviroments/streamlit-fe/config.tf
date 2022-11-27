terraform {

    backend "s3" {
      # Replace this with your bucket name!
      bucket         = "terraform-up-and-running-state-streamlit-app-ventures"
      key            = "global/s3/terraform.tfstate"
      region         = "eu-central-1"

      # Replace this with your DynamoDB table name!
      dynamodb_table = "terraform-up-and-running-locks"
      encrypt        = true
    }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
  }
}

provider "aws" {
  allowed_account_ids = [var.aws_account_id]
  region              = "eu-central-1"

}

