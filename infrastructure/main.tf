

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

module "static-website" {
  source              = "github.com/larswillrich/tf-aws-static-website-module"
  domain              = "larswillrich.com"
  default_root_object = "index.html"
}