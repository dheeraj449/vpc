terraform {
  backend "s3" {
    bucket         = "dheeraj-terraform-backend-2025"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "dheeraj-tf-lock"
    encrypt        = true
  }
}
