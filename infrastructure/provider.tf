
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-state-lars-willrich"
    key            = "larswillrich/personalWebsite/terraform.tfstate"
    region         = "eu-central-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
  
  #assume_role {
  #  role_arn     = "arn:aws:iam::380702078761:role/OrganizationAccountAccessRole"
  #}
}