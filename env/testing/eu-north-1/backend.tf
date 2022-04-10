terraform {
  backend "s3" {
    bucket         = "terraform-state-charly3101" 
    key            = "global/s3/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-charly3101-locks"
    encrypt        = true
  }
}
